# frozen_string_literal: true

module V1::Admin
  class ReservationsController < ApplicationController
    before_action :find_item, only: %i[show deliver_confirmation_email update destroy update_status add_tag remove_tag]
    before_action :find_tag, only: %i[add_tag remove_tag]

    def index
      call = ::SearchReservations.run(params:, current_user:)
      unless call.valid?
        return render_error(status: 400, details: call.errors.as_json,
                            message: call.errors.full_messages.join(", "))
      end

      items = call.result.paginate(pagination_params)

      render json: {
        items: full_json(items),
        metadata: json_metadata(items)
      }
    end

    # GET /v1/admin/reservations/resume
    # Will return a hash with the number of tables for people quantity.
    # <table_size> => <number_of_tables>
    def tables_summary
      call = TablesSummary.run(params: params.permit!.to_h, current_user:)

      unless call.valid?
        return render_error(status: 400, details: call.errors.as_json,
                            message: call.errors.full_messages.join(", "))
      end

      render json: call.result
    end

    def show
      render json: { item: full_json(@item) }
    end

    def create
      @item = ::Reservation.new(create_params)

      return show if @item.valid? && @item.save

      render_unprocessable_entity(@item)
    end

    def update
      return show if @item.update(update_params)

      render_unprocessable_entity(@item)
    end

    def destroy
      return if @item.deleted!

      render_unprocessable_entity(@item)
    rescue ActiveRecord::RecordInvalid
      render_unprocessable_entity(@item)
    end

    def update_status
      status = params[:status].to_s.gsub(/\s+/, "").downcase
      return render_error(status: 400, message: I18n.t("invalid_status")) unless %w[arrived noshow
                                                                                    active].include?(status)

      return show if @item.update(status:)

      render_unprocessable_entity(@item)
    end

    def add_tag
      @item.tags << @tag
      show
    rescue ActiveRecord::RecordInvalid => e
      render_error(status: 422, message: e)
    end

    def remove_tag
      @item.tags.delete(@tag)
      show
    end

    def deliver_confirmation_email
      if @item.email.blank?
        return render_error(status: 400,
                            message: I18n.t("reservation_mailer.confirmation.no_email"))
      end

      @item.deliver_confirmation_email
      show
    end

    private

    def create_params
      params.permit(:fullname, :datetime, :children, :adults, :table, :notes, :email, :phone)
    end

    def update_params
      params.permit(:fullname, :datetime, :children, :adults, :table, :notes, :email, :phone)
    end

    def full_json(item_or_items)
      return item_or_items.map { |item| full_json(item) } if item_or_items.is_a?(ActiveRecord::Relation)

      return single_item_full_json(item_or_items) if item_or_items.is_a?(::Reservation)

      raise ArgumentError,
            "Invalid params. Reservation or ActiveRecord::Relation expected, but #{item_or_items.class} given"
    end

    def single_item_full_json(item)
      item.as_json(
        include: [
          {
            payment: {
              only: %i[id hpp_url status value]
            },
            delivered_emails: {
              only: %i[id created_at updated_at],
              include: [{ image_pixels: { include: %i[events] } }]
            }
          },
          :tags
        ]
      )
    end

    def find_item
      @item = Reservation.visible.find_by(id: params[:id])
      return unless @item.nil?

      render_error(status: 404,
                   message: I18n.t("record_not_found", model: Reservation,
                                                       id: params[:id].inspect))
    end

    def find_tag
      @tag = ReservationTag.visible.where(id: params[:tag_id]).first
      return unless @tag.nil?

      render_error(status: 404,
                   message: I18n.t("record_not_found", model: ReservationTag,
                                                       id: params[:tag_id].inspect))
    end
  end
end
