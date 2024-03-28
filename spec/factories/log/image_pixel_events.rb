FactoryBot.define do
  factory :log_image_pixel_event, class: "Log::ImagePixelEvent" do
    event_time { Time.now }
  end
end
