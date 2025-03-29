# frozen_string_literal: true

class ValidTimesGroupByTurn < ActiveInteraction::Base
  # people: Integer
  # How many people are trying to reserve. Optional.
  # Useful to understand if a TableType can be returned based on availability.
  # integer :people, default: 0
  interface :params, methods: %i[merge to_h], default: {}

  validate do
    errors.add(:date, "is missing or invalid.") if date.blank?
  end

  def execute
    ReservationTurn.visible.where(weekday: date.wday).includes(
      reservation_turn_messages: [:text_translations]
    ).map do |turn|
      process_turn(turn)
    end.flatten
  end

  private

  def process_turn(turn)
    turn.as_json.merge(
      valid_times: turn.valid_times(date: params[:date]),
      preorder_reservation_group: group_json(turn),
      messages: turn.reservation_turn_messages.active_at(date).map do |m|
        m.as_json(
          only: %i[id from_date to_date],
          methods: %i[message]
        )
      end
    )
  end

  # Will format PreorderReservationGroup's data.
  # Will returned data like this:
  # {
  #   messsage: String,
  #   table_type_to_preorder_reservation_groups: [
  #     {
  #       people_per_turn: Integer,
  #       price: Float,
  #       table_type: {
  #         name: String,
  #         description: String,
  #         images: [
  #           {
  #             id: Integer,
  #             filename: String,
  #             status: String,
  #             ...
  #             url: String
  #           }
  #         ]
  #       }
  #     }
  #   ]
  # }
  def group_json(turn)
    item = turn.preorder_reservation_groups.active.first
    return nil if item.nil?

    table_type_to_preorder_reservation_groups = item.table_type_to_preorder_reservation_groups.includes(table_type: [
                                                                                                          :text_translations, { images: [:attached_image_blob] }
                                                                                                        ]).map do |join|
      free_seats = AvailableSeatsForReservationTurnAndPgroup.run!(
        reservation_turn: turn,
        pgroup: item,
        table_type: join.table_type,
        datetime: date
      )
      next nil if free_seats.zero?
      next nil if params[:people].present? && free_seats < params[:people].to_i

      join.as_json(
        only: %i[people_per_turn price table_type_id]
      ).merge(
        table_type: join.table_type.public_json
      )
    end.filter(&:present?)

    item.as_json(
      methods: %i[message]
    ).merge(
      table_type_to_preorder_reservation_groups:
    )
  end

  def date
    return @date if defined?(@date)
    return @date = nil if params[:date].blank?

    @date ||= Date.parse(params[:date].to_s)
  rescue Date::Error => e
    @date = nil
    errors.add(:date, e)
  end
end
