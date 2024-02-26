# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: Config.app.dig(:emails, :default_from),
          reply_to: Config.app.dig(:emails, :default_reply_to) || Config.app.dig(:emails, :default_from)

  layout 'mailer'

  before_action do
    headers 'X-ApplicationSender' => 'lpda2'

    @images = Image.where("key ILIKE 'email_images_%'").all.map do |image|
      [
        image.key.split('email_images_').last,
        image.download_by_key_url
      ]
    end.to_h.with_indifferent_access

    @contacts = Setting[:email_contacts]
  end

  def contact(key, raise_missing: true)
    byebug
  end
end
