# frozen_string_literal: true

require "rails_helper"

RSpec.describe UserMailer do
  subject { mail }

  let(:default_params) { { user: user, token: token } }
  let(:user) { create(:user, :with_fullname) }
  let(:token) { "some-super-secret-token" }

  context "when calling #password_updated prepended #with(...)" do
    def mail(params = default_params)
      described_class.with(params).password_updated.deliver_now
    end

    it { expect(mail.to).to eq([user.email]) }

    it do
      expect(mail.subject).to eq I18n.t("user_mailer.password_updated.subject")
    end

    context "when checking text part body" do
      subject(:body) { mail.text_part.body.encoded }

      it do
        expect(body).to include(I18n.t("mail.greetings"))
      end

      it do
        expect(body).to include(I18n.t("user_mailer.password_updated.body", app_name: Config.hash[:app_name], email: user.email))
      end

      it do
        expect(body).not_to include("<a ")
      end

      it do
        expect(body).not_to include("href=")
      end
    end

    context "when checking html part body" do
      subject(:body) { mail.html_part.body.encoded }

      it do
        expect(body).to include(CGI.escapeHTML(I18n.t("mail.greetings")))
      end

      it do
        expect(body).to include(CGI.escapeHTML(I18n.t("user_mailer.password_updated.body", app_name: Config.hash[:app_name], email: user.email)))
      end
    end

    %w[it en].each do |lang|
      it "when language is #{lang.inspect}, subject should be #{I18n.t("user_mailer.password_updated.subject", locale: lang).inspect}" do
        I18n.with_locale(lang) do
          expect(mail.subject).to eq I18n.t("user_mailer.password_updated.subject")
        end
      end

      context "when language is #{lang}" do
        it do
          I18n.with_locale(lang) do
            expect(mail.text_part.body.encoded).to include I18n.t("user_mailer.password_updated.body", app_name: Config.hash[:app_name], email: user.email)
          end
        end

        it do
          I18n.with_locale(lang) do
            expect(mail.html_part.body.encoded).to include CGI.escapeHTML(I18n.t("user_mailer.password_updated.body", app_name: Config.hash[:app_name], email: user.email))
          end
        end
      end
    end

    it "if token is nil won't raise error" do
      expect { mail(default_params.merge(token: nil)) }.not_to raise_error
    end

    it "if token is blank won't raise error" do
      expect { mail(default_params.merge(token: "")) }.not_to raise_error
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
