# frozen_string_literal: true

module V1::Admin
  class ReservationsController < ApplicationController
    before_action :find_item,
                  only: %i[show refund_payment record_deferred_payment refresh_payment_status deliver_confirmation_email update destroy update_status add_tag
                           remove_tag create_payment]
    before_action :find_tag, only: %i[add_tag remove_tag]
    before_action :require_root, only: %i[refund_payment record_deferred_payment create_payment refresh_payment_status]

    def index
      call = ::SearchReservations.run(params:)
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
    # Will return a hash with the number of tables for people quantity, grouped by turn.
    def tables_summary
      call = TablesSummary.run(params: params.permit!.to_h, current_user:)

      unless call.valid?
        return render_error(status: 400, details: call.errors.as_json,
                            message: call.errors.full_messages.join(", "))
      end

      render json: call.result
    end

    # GET /v1/admin/reservations/ungrouped_tables_summary
    # Will return a hash with the number of tables for people quantity.
    # <table_size> => <number_of_tables>
    def ungrouped_tables_summary
      search = ::SearchReservations.run(params:)

      unless search.valid?
        return render_error(status: 400, details: search.errors.as_json,
                            message: search.errors.full_messages.join(", "))
      end

      render json: Reservation.where(id: search.result.select(:id)).group("children + adults").count
    end

    def show
      render json: { item: full_json(@item) }
    end

    def create
      @item = ::Reservation.new(create_params)

      return show if @item.valid? && @item.save

      render_unprocessable_entity(@item)
    end

    # POST /v1/admin/reservations/:id/refund_payment
    def refund_payment
      call = RefundReservationPayment.run(reservation: @item)

      if call.valid?
        @item.reload
        return show
      end

      render_unprocessable_entity(call)
    end

    # POST /v1/admin/reservations/:id/record_deferred_payment
    # This is used to, given a card hold, actually charge the card.
    def record_deferred_payment
      call = RecordDeferredPayment.run(payment: @item.payment)

      if call.valid?
        @item.reload
        return show
      end

      render_unprocessable_entity(call)
    end

    # POST /v1/admin/reservations/:id/refresh_payment_status
    def refresh_payment_status
      call = FetchReservationPaymentStatus.run(reservation_payment: @item.payment)

      if call.valid?
        @item.reload
        return show
      end

      render_unprocessable_entity(call)
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
                                                                                    active cancelled].include?(status)

      return show if @item.update(status:)

      render_unprocessable_entity(@item)
    end

    # POST /v1/admin/reservations/:id/payment
    def create_payment
      call = AdminCreateReservationPayment.run(reservation: @item, params: params.permit!.to_h)

      return render_unprocessable_entity(call) if call.errors.any? || call.invalid?

      render json: {
        item: full_json(@item),
        call: call.result
      }
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

    def export
      search = ::SearchReservations.run(params:)
      unless search.valid?
        return render_error(status: 400, details: search.errors.as_json,
                            message: search.errors.full_messages.join(", "))
      end

      export = ExportReservations.run(reservations: search.result)
      unless export.valid?
        return render_error(status: 400, details: export.errors.as_json,
                            message: export.errors.full_messages.join(", "))
      end

      send_file export.result, filename: "Prenotazioni.xlsx",
                               type: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    end

    private

    def create_params
      params.permit(:fullname, :datetime, :children, :adults, :table, :notes, :email, :phone)
    end

    def update_params
      params.permit(:fullname, :datetime, :children, :adults, :table, :notes, :email, :phone)
    end

    def full_json(item_or_items)
      if item_or_items.is_a?(ActiveRecord::Relation)
        return item_or_items.includes(:reservation_tags, :delivered_emails, :payment,
                                      table_type: [:text_translations, { images: [:attached_image_blob] }]).map do |item|
                 full_json(item)
               end
      end

      return single_item_full_json(item_or_items) if item_or_items.is_a?(::Reservation)

      raise ArgumentError,
            "Invalid params. Reservation or ActiveRecord::Relation expected, but #{item_or_items.class} given"
    end

    def single_item_full_json(item)
      item.as_json(
        include: [
          {
            table_type: {
              methods: %i[name description],
              include: [{ images: { methods: %i[full_json] } }]
            },
            payment: {
              only: %i[id hpp_url status external_id preorder_type value]
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
