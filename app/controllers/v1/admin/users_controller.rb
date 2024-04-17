# frozen_string_literal: true

module V1::Admin
  # CRUD users
  class UsersController < ApplicationController
    before_action :find_item, only: %i[show destroy]

    def index
      call = ::SearchUsers.run(params:, current_user:)
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
      @item = User.new(create_params)

      return show if @item.valid? && @item.save && @item.persisted?

      render_unprocessable_entity(@item)
    end

    def update_status
      return show if @item.update(status: params[:status])

      render_unprocessable_entity(@item)
    end

    def destroy
      return if @item.deleted!

      render_unprocessable_entity(@item)
    rescue ActiveRecord::RecordInvalid
      render_unprocessable_entity(@item)
    end

    private

    def create_params
      params.permit(:email, :fullname)
    end

    def find_item
      @item = User.visible.where(id: params[:id]).first
      return unless @item.nil?

      render_error(status: 404,
                   message: I18n.t("record_not_found", model: User,
                                                       id: params[:id].inspect))
    end

    def full_json(item_or_items)
      return item_or_items.map { |item| full_json(item) } if item_or_items.is_a?(ActiveRecord::Relation)

      return single_item_full_json(item_or_items) if item_or_items.is_a?(::User)

      raise ArgumentError,
            "Invalid params. User or ActiveRecord::Relation expected, but #{item_or_items.class} given"
    end

    def single_item_full_json(item)
      item.as_json(only: %i[id email fullname status created_at updated_at])
    end
  end
end
