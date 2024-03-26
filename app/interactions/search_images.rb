# frozen_string_literal: true

# Filter Image records by hash or controller params.
class SearchImages < ActiveInteraction::Base
  interface :params, methods: %i[[] merge! fetch each has_key?], default: {}

  def execute
    items = Image.all

    # if params[:record_type].present?
    #   items = items.where(id: ImageToRecord.where(record_type: params[:record_type]).select(:image_id))
    # end
    #
    # if params[:record_id].present?
    #   items = items.where(id: ImageToRecord.where(record_id: params[:record_id]).select(:image_id))
    # end

    %i[id filename status tag original_id key].each do |field|
      items = items.where(field => params[field]) if params[field].present?
    end

    items = items.where('filename LIKE ?', "%#{params[:query]}%") if params[:query].present?

    if record_type.present? && params[:record_id].present?
      #   TODO order by ImageToRecord.position
      items = items.joins(:image_to_records).where(
        'image_to_records.record_type = ? AND image_to_records.record_id = ?', record_type, params[:record_id].to_s
      )
                   .order('image_to_records.position')
    end

    items
  end

  def record_type
    params[:record_type].to_s.gsub(/\s+/, '').split('::').map(&:capitalize).join('::')
  end
end
