# frozen_string_literal: true

module V1::Admin
  # Will manage /v1/admin/holidays requests
  class HolidaysController < ApplicationController
    before_action :find_item, only: %i[show update destroy]

    def index
      call = ::SearchHolidays.run(params:)
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

    def show
      render json: {
        item: full_json(@item)
      }
    end

    def create
      @item = Holiday.new(create_params)

      @item.assign_translation("message", params[:message])

      if @item.valid? && @item.save
        @item.reload
        return show
      end

      render_unprocessable_entity(@item)
    end

    def update
      @item.assign_translation("message", params[:message])

      if @item.update(update_params)
        @item.reload
        return show
      end

      render_unprocessable_entity(@item)
    end

    def destroy
      return if @item.destroy

      render_unprocessable_entity(@item)
    end

    private

    def update_params
      params.permit(:from_timestamp, :to_timestamp, :weekly_from, :weekly_to, :weekday, :message)
    end

    def create_params
      update_params
    end

    def full_json(item_or_items)
      return item_or_items.map { |item| full_json(item) } if item_or_items.is_a?(ActiveRecord::Relation)

      return single_item_full_json(item_or_items) if item_or_items.is_a?(Holiday)

      raise ArgumentError, "Invalid params. Holiday or ActiveRecord::Relation expected, but #{item_or_items.class} given"
    end

    def single_item_full_json(item)
      item.as_json.merge(
        "from_timestamp" => item.from_timestamp&.strftime("%Y-%m-%d %H:%M"),
        "to_timestamp" => item.to_timestamp&.strftime("%Y-%m-%d %H:%M"),
        "weekly_from" => item.weekly_from&.strftime("%H:%M"),
        "weekly_to" => item.weekly_to&.strftime("%H:%M")
      )
    end

    def find_item
      @item = Holiday.visible.find_by(id: params[:id])
      return unless @item.nil?

      render_error(status: 404,
                   message: I18n.t("record_not_found", model: Holiday,
                                                       id: params[:id].inspect))
    end
  end
end
