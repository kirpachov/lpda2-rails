# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: Config.app.dig(:emails, :default_from),
          reply_to: Config.app.dig(:emails, :default_reply_to) || Config.app.dig(:emails, :default_from)

  layout 'mailer'

  before_action do
    headers 'X-ApplicationSender' => 'lpda2'

    @images = Setting[:email_images]
    @contacts = Setting[:email_contacts]
  end

  def contact(key, raise_missing: true)
    byebug
  end
end
