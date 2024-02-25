# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: Config.app[:emails][:default_from],
          reply_to: Config.app[:emails][:default_reply_to] || Config.app[:emails][:default_from]

  layout 'mailer'

  before_action do
    headers 'X-ApplicationSender' => 'lpda2'

    # TODO may make this configurable by user.
    # @images = Config.hash[:email_images]
    # @contacts = Config.hash[:email_contacts]
    @images = Setting[:email_images]
    @contacts = Setting[:email_contacts]
  end

  def contact(key, raise_missing: true)
    byebug
  end
end
