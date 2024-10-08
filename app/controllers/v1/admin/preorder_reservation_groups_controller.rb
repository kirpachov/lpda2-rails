# frozen_string_literal: true

module V1::Admin
  class PreorderReservationGroupsController < ApplicationController
    before_action :find_item, only: %i[show update destroy]

    def index
      items = PreorderReservationGroup.visible.order(id: :desc)

      items = items.paginate(pagination_params)

      render json: {
        items: full_json(items),
        metadata: json_metadata(items)
      }
    end

    def show
      render json: { item: full_json(@item) }
    end

    def create
      @call = CreatePreorderGroup.run(params: params.permit!.to_h)

      return render_unprocessable_entity(@call) if @call.invalid?

      @item = @call.result

      show
    end

    def update
      raise "not implemented"
      # TODO update group and dates
      # return show if @item.update(update_params)

      # render_unprocessable_entity(@item)
    end

    def destroy
      raise "not implemented"
      # nil if @item.destroy!

      #   render_unprocessable_entity(@item)
      # rescue ActiveRecord::RecordInvalid
      #   render_unprocessable_entity(@item)
    end

    private

    # def create_params
    #   params.permit(:weekday, :starts_at, :ends_at, :name)
    # end

    # def update_params
    #   params.permit(:weekday, :starts_at, :ends_at, :name)
    # end

    def find_item
      @item = PreorderReservationGroup.find_by(id: params[:id])
      return unless @item.nil?

      render_error(status: 404,
                   message: I18n.t("record_not_found", model: PreorderReservationGroup,
                                                       id: params[:id].inspect))
    end

    def full_json(item_or_items)
      return item_or_items.map { |item| full_json(item) } if item_or_items.is_a?(ActiveRecord::Relation)

      return single_item_full_json(item_or_items) if item_or_items.is_a?(::PreorderReservationGroup)

      raise ArgumentError,
            "Invalid params. PreorderReservationGroup or ActiveRecord::Relation expected, but #{item_or_items.class} given"
    end

    def single_item_full_json(item)
      item.as_json(include: %w[dates turns])
    end
  end
end