# frozen_string_literal: true

class SearchHolidays < ActiveInteraction::Base
  interface :params, methods: %i[[] merge! fetch each has_key?], default: {}

  def execute
    @items = Holiday.visible

    @items = @items.where(weekday: params[:weekday]) if params[:weekday].present?

    @items = @items.active_at(params[:active_at]) if params[:active_at].present?

    @items = @items.active_at(Time.zone.now) if params[:active_now].to_s.true?

    @items
  end
end
