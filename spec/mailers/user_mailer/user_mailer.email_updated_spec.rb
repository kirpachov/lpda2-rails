# frozen_string_literal: true

require "rails_helper"

RSpec.describe UserMailer do
  subject { mail }

  let(:default_params) { { user_id:, old_email: } }
  let(:old_email) { Faker::Internet.email }
  let(:user_id) { user.id }
  let(:user) { create(:user, :with_fullname) }

  context "when calling #email_updated prepended #with(...)" do
    def mail(params = default_params)
      described_class.with(params).email_updated.deliver_now
    end

    it { expect(mail.to).to eq([old_email]) }

    it do
      expect(mail.subject).to eq I18n.t("user_mailer.email_updated.subject")
    end

    [
      "en",
      "it"
    ].each do |lang|
      it do
        I18n.with_locale(lang) do
          expect(mail.subject).to eq I18n.t("user_mailer.email_updated.subject", locale: lang)
        end
      end
    end

    it do
      expect(I18n.t("user_mailer.email_updated.subject", locale: "it")).not_to eq(I18n.t("user_mailer.email_updated.subject", locale: "en"))
    end

    context "when checking text part body" do
      subject(:body) { mail.text_part.body.encoded }

      it do
        expect(body).to include(I18n.t("mail.greetings"))
      end

      it do
        expect(body).to include(I18n.t("user_mailer.email_updated.body", old_email:, new_email: user.email))
      end

      it do
        expect(body).to include(I18n.t("user_mailer.email_updated.closing"))
      end

      it do
        expect(body).not_to include("<a ")
      end

      it do
        expect(body).not_to include("href=")
      end

      %w[it en].each do |locale|
        it do
          I18n.with_locale(locale) do
            expect(body).to include(user.email)
          end
        end

        it do
          expect(body).to include(old_email)
        end
      end
    end

    context "when checking html part body" do
      subject(:body) { mail.html_part.body.encoded }

      it do
        expect(body).to include(CGI.escapeHTML(I18n.t("mail.greetings")))
      end

      it do
        expect(body).to include(CGI.escapeHTML(I18n.t("user_mailer.email_updated.body", old_email:, new_email: user.email)))
      end

      it do
        expect(body).to include(CGI.escapeHTML(I18n.t("user_mailer.email_updated.closing")))
      end

      %w[it en].each do |locale|
        it do
          I18n.with_locale(locale) do
            expect(body).to include(CGI.escapeHTML(user.email))
          end
        end

        it do
          expect(body).to include(CGI.escapeHTML(old_email))
        end
      end
    end

    %w[it en].each do |lang|
      it "when language is #{lang.inspect}, subject should be #{I18n.t("user_mailer.email_updated.subject",
                                                                       locale: lang).inspect}" do
        I18n.with_locale(lang) do
          expect(mail.subject).to eq I18n.t("user_mailer.email_updated.subject")
        end
      end

      context "when language is #{lang}" do
        it do
          I18n.with_locale(lang) do
            expect(mail.text_part.body.encoded).to include I18n.t("user_mailer.email_updated.body", old_email:, new_email: user.email)
          end
        end

        it do
          I18n.with_locale(lang) do
            expect(mail.text_part.body.encoded).to include I18n.t("user_mailer.email_updated.closing")
          end
        end

        # it do
        #   I18n.with_locale(lang) do
        #     expect(mail.html_part.body.encoded).to include CGI.escapeHTML(I18n.t("user_mailer.email_updated.body", old_email:, new_email: user.email))
        #   end
        # end
      end
    end

    it "if user is nil raise error" do
      expect { mail(default_params.merge(user: nil, user_id: nil)) }.to raise_error(ArgumentError)
    end

    it "if user is not persisted raise error" do
      expect { mail(default_params.merge(user: build(:user, :with_fullname))) }.to raise_error(ArgumentError)
    end

    it "if user is deleted raise error" do
      user.deleted!
      expect { mail(default_params) }.to raise_error(ArgumentError)
      user.active!
      expect { mail(default_params) }.not_to raise_error
    end

    it "if user_id is provided instead of user, it's valid." do
      expect { mail(default_params.merge(user: nil, user_id: user.id)) }.not_to raise_error
    end
  end
end
