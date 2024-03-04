class CreateLogImagePixelEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :log_image_pixel_events do |t|
      t.belongs_to  :image_pixel, null: false, foreign_key: { to_table: 'log_image_pixels' }, class_name: 'Log::ImagePixel'
      t.jsonb       :event_data,      null: true, default: {}
      t.datetime    :event_time,   null: false

      t.timestamps
    end
  end
end
