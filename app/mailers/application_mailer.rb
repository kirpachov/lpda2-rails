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

    if params[:pixel].is_a?(Hash)
      params[:pixel].each do |key, url|
        @images[key] = url
      end
    end

    @contacts = Setting[:email_contacts]
  end

  after_action do
    delivered_email = params[:delivered_email] || Log::DeliveredEmail.create!

    delivered_email.update!(
      text: mail.text_part&.body&.decoded,
      html: mail.html_part&.body&.decoded,
      subject: mail.subject,
      headers: mail.header.fields.map { |field| [field.name, field.value] }.to_h,
      raw: mail.to_s
    )
  end
end
