# frozen_string_literal: true

require "rails_helper"

RSpec.describe ReservationMailer do
  subject { mail }

  before do
    CreateMissingImages.run!
  end

  let(:reservation) { create(:reservation) }
  let(:default_params) { reservation.confirmation_email_params }

  context "when calling #confirmation prepended #with(...)" do
    around do |example|
      Time.use_zone(Config.app.dig!(:restaurant_location_time_zone)) do
        example.run
      end
    end

    def mail(params = default_params)
      described_class.with(params).confirmation.deliver_now
    end

    it { expect(mail.to).to eq([reservation.email]) }

    it do
      expect(mail.subject).to eq I18n.t("reservation_mailer.confirmation.subject", fullname: reservation.fullname)
    end

    context "when reservation has a payment in status 'paid'" do
      before do
        create(:reservation_payment, reservation:, status: :paid)
      end

      it { expect(reservation.reload.payment).to be_paid }
      it { expect(mail.text_part.body.encoded).to include(I18n.t("reservation_mailer.confirmation.payment_completed")) }

      it {
        expect(mail.html_part.body.encoded).to include(CGI.escapeHTML(I18n.t("reservation_mailer.confirmation.payment_completed")))
      }
    end

    context "when reservation has a payment in status 'todo'" do
      before do
        create(:reservation_payment, reservation:, status: :todo)
      end

      it { expect(reservation.reload.payment).to be_todo }
      it { expect(mail.text_part.body.encoded).to include(I18n.t("reservation_mailer.confirmation.remember_payment")) }

      it {
        expect(mail.html_part.body.encoded).to include(CGI.escapeHTML(I18n.t("reservation_mailer.confirmation.remember_payment")))
      }

      it do
        expect(mail.html_part.body.encoded).to(include(reservation.reload.payment.hpp_url))
        expect(mail.html_part.body.encoded).to(include(reservation.reload&.payment&.do_payment_url))
      end
    end

    context "when reservation has a payment in status 'todo' of kind stripe_payment" do
      before do
        create(:reservation_payment, :stripe_payment, reservation:, status: :todo)
      end

      it { expect(reservation.reload.payment).to be_todo }
      it { expect(mail.text_part.body.encoded).to include(I18n.t("reservation_mailer.confirmation.remember_payment")) }

      it {
        expect(mail.html_part.body.encoded).to include(CGI.escapeHTML(I18n.t("reservation_mailer.confirmation.remember_payment")))
      }

      it do
        expect(mail.html_part.body.encoded).not_to(include(reservation.reload.payment.hpp_url))
        expect(mail.html_part.body.encoded).to(include(reservation.reload&.payment&.do_payment_url))
      end
    end

    context "when reservation don't have a payment" do
      it { expect(reservation.reload.payment).to be_nil }

      it {
        expect(mail.text_part.body.encoded).not_to include(I18n.t("reservation_mailer.confirmation.remember_payment"))
      }

      it {
        expect(mail.html_part.body.encoded).not_to include(I18n.t("reservation_mailer.confirmation.remember_payment"))
      }

      it {
        expect(mail.html_part.body.encoded).not_to include(CGI.escapeHTML(I18n.t("reservation_mailer.confirmation.remember_payment")))
      }
    end

    context "when checking text part body" do
      subject(:body) { mail.text_part.body.encoded }

      it do
        expect(body).not_to include("<a ")
      end

      it do
        expect(body).not_to include("href=")
      end
    end

    %w[it en].each do |lang|
      context "when language is #{lang}" do
        before { reservation.update!(lang:) }

        it "links should include locale in the path" do
          expect(mail.html_part.body.encoded).to include("/#{lang}/#/")
        end

        it do
          expect(mail.subject).to eq I18n.t("reservation_mailer.confirmation.subject", fullname: reservation.fullname,
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

    %i[
      address
      facebook_url
      instagram_url
      tripadvisor_url
      google_url
    ].each do |contact_key|
      [
        "",
        nil
      ].each do |blank_value|
        context "when Contact #{contact_key.inspect} is missing (#{blank_value.inspect})" do
          before { Contact.create!(key: contact_key, value: blank_value) }

          it { expect { mail }.not_to raise_error }
          it { expect(mail.text_part.body.encoded).not_to include(Contact::DEFAULTS[contact_key][:value]) }
          it { expect(mail.html_part.body.encoded).not_to include(Contact::DEFAULTS[contact_key][:value]) }
        end
      end
    end
  end
end
