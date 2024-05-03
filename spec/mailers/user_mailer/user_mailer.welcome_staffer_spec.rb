# frozen_string_literal: true

require "rails_helper"

RSpec.describe UserMailer do
  subject { mail }

  let(:default_params) { { user: user, token: token } }
  let(:user) { create(:user, :with_fullname) }
  let(:token) { "some-super-secret-token" }

  context "when calling #welcome_staffer prepended #with(...)" do
    def mail(params = default_params)
      described_class.with(params).welcome_staffer.deliver_now
    end

    it { expect(mail.to).to eq([user.email]) }

    it do
      expect(mail.subject).to eq I18n.t("user_mailer.welcome_staffer.subject")
    end

    it { expect(mail.body.encoded).to include(token) }
    it { expect(mail.body.encoded).to include("http") }

    context "when checking text part body" do
      subject(:body) { mail.text_part.body.encoded }

      it do
        expect(body).not_to include(CGI.escapeHTML(I18n.t("mail.if_button_does_not_work_copy_and_paste_above")))
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
        expect(body).to include(CGI.escapeHTML(I18n.t("mail.if_button_does_not_work_copy_and_paste_above")))
      end

      it do
        expect(body).to include("<a ")
      end

      it do
        expect(body).to include("href=")
      end
    end

    it do
      data = { reset_password_url: "{{frontend_base_url}}/auth/reset-password/{{token}}", frontend_base_url: "https://example.com" }
      # Want to allow to call both #app or #hash since may be using both, they do the same thing
      allow(Config).to receive_messages(app: data, hash: data)
      expect(mail.body.encoded).to include("https://example.com/auth/reset-password/#{token}")
    end

    %w[it en].each do |lang|
      context "when language is #{lang.inspect}" do
        it do
          I18n.with_locale(lang) do
            expect(mail.subject).to eq I18n.t("user_mailer.welcome_staffer.subject")
          end
        end

        it do
          I18n.with_locale(lang) do
            expect(mail.html_part.body.encoded).not_to include(CGI.escapeHTML(I18n.t("user_mailer.welcome_staffer.subject")))
          end
        end

        it do
          I18n.with_locale(lang) do
            expect(mail.text_part.body.encoded).not_to include(I18n.t("user_mailer.welcome_staffer.subject"))
          end
        end

        it do
          I18n.with_locale(lang) do
            expect(mail.html_part.body.encoded).to include CGI.escapeHTML(I18n.t("user_mailer.welcome_staffer.body"))
          end
        end

        it do
          I18n.with_locale(lang) do
            expect(mail.text_part.body.encoded).to include I18n.t("user_mailer.welcome_staffer.body")
          end
        end
      end
    end

    it "if token is nil raise error" do
      expect { mail(default_params.merge(token: nil)) }.to raise_error(ArgumentError)
    end

    it "if token is blank raise error" do
      expect { mail(default_params.merge(token: "")) }.to raise_error(ArgumentError)
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
