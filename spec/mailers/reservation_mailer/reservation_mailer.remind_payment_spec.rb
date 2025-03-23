# frozen_string_literal: true

require "rails_helper"

RSpec.describe ReservationMailer do
  subject { mail }

  before do
    CreateMissingImages.run!
  end

  let(:reservation) { create(:reservation, :with_fullname) }
  let(:default_params) { { reservation_id: reservation.id } }

  it { expect(reservation.fullname).to be_present }

  [
    nil,
    {},
    { reservation_id: nil },
    { reservation_id: 0 },
    { reservation: nil },
    { reservation: "string" },
    { reservation_id: 999_999_999_999 }
  ].each do |params|
    context "when calling #remind_payment with params #{params.inspect}" do
      let(:mail) { described_class.with(params).remind_payment.deliver_now }

      it do
        expect { mail }.to raise_error(ArgumentError)
      end
    end
  end

  [
    "",
    nil
  ].each do |missing_mail|
    context "when email is missing or invalid (#{missing_mail.inspect})" do
      before do
        reservation.update!(email: missing_mail)
      end

      let(:mail) do
        described_class.with(default_params).remind_payment.deliver_now
      end

      it { expect { mail }.to raise_error(ArgumentError) }
    end
  end

  context "when calling #remind_payment prepended #with(...)" do
    around do |example|
      Time.use_zone(Config.app.dig!(:restaurant_location_time_zone)) do
        example.run
      end
    end

    let(:mail) do
      described_class.with(default_params).remind_payment.deliver_now
    end

    it { expect(mail.to).to include(reservation.email) }

    it do
      mail_to = mail.to_s.split("\n").flatten.filter { |j| j.starts_with?("To:") }.last
      expect(mail_to.delete('"')).to include("#{reservation.fullname} <#{reservation.email}>")
    end

    it do
      expect(mail.subject).to eq I18n.t("reservation_mailer.remind_payment.subject", fullname: reservation.fullname)
    end

    it do
      expect { mail }.to(change { Log::DeliveredEmail.count }.by(1))
    end

    it do
      mail
      expect(Log::DeliveredEmail.last.record_id).to eq(reservation.id)
      expect(Log::DeliveredEmail.last.record_type).to eq("Reservation")
      expect(Log::DeliveredEmail.last.record.id).to eq(reservation.id)
    end

    context "when checking text part body" do
      subject(:body) { mail.text_part.body.encoded }

      it do
        expect(body).not_to include("<a ")
      end

      it do
        expect(body).not_to include("href=")
      end

      it do
        expect(body).to include("http")
      end

      it do
        expect(body).to include(
          Mustache.render(Config.hash[:show_reservation_url], { secret: reservation.secret })
        )
      end

      it do
        expect(body).to include(reservation.secret)
      end
    end

    %w[it en].each do |lang|
      context "when language is #{lang}" do
        before { reservation.update!(lang:) }

        it "links should include locale in the path" do
          expect(mail.html_part.body.encoded).to include("/#{lang}/#/")
        end

        it do
          expect(mail.text_part.body.encoded).to include(
            I18n.t(
              "reservation_mailer.remind_payment.body",
              date: I18n.l(reservation.datetime, format: "%e %B %Y", locale: lang),
              hour: ignore_dst(reservation.datetime).strftime("%k:%M"),
              people: reservation.people,
              locale: lang
            )
          )
        end

        it do
          expect(mail.subject).to eq I18n.t("reservation_mailer.remind_payment.subject", fullname: reservation.fullname,
                                                                                         locale: lang)
        end

        it do
          expect(mail.text_part.body.encoded).to include I18n.t("reservation_mailer.greetings",
                                                                fullname: reservation.fullname, locale: lang)
        end

        it do
          expect(mail.html_part.body.encoded).to include CGI.escapeHTML(I18n.t("reservation_mailer.greetings",
                                                                               fullname: reservation.fullname, locale: lang))
        end
      end
    end
  end
end
