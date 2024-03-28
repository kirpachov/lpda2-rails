# frozen_string_literal: true

require "rails_helper"

RSpec.describe Menu::CopyIngredient, type: :interaction do
  describe "#execute" do
    subject { described_class.run(params) }

    let!(:ingredient) { create(:menu_ingredient) }
    let!(:current_user) { create(:user) }
    let(:old) { ingredient }
    let(:params) { { old:, current_user: } }

    context "basic" do
      it "creates a new ingredient" do
        expect { subject }.to change(Menu::Ingredient, :count).by(1)
      end

      it "call is valid" do
        expect(subject).to be_valid
      end

      it "returns ingredient" do
        expect(subject.result).to be_a(Menu::Ingredient)
        expect(subject.result).to be_valid
        expect(subject.result).to be_persisted
      end

      it "enqueue a job to save the changes with current user info" do
        allow(SaveModelChangeJob).to receive(:perform_async).with(include("user_id" => current_user.id))
        subject
      end
    end

    context "should copy name and description translations" do
      before do
        I18n.available_locales.each do |locale|
          Mobility.with_locale(locale) do
            old.name = "Name in #{locale}"
            old.description = "Description in #{locale}"
          end
        end

        old.save!
      end

      context "checking mock data" do
        it "has name and description in all available locales" do
          I18n.available_locales.each do |locale|
            Mobility.with_locale(locale) do
              expect(old.name).to eq("Name in #{locale}")
              expect(old.description).to eq("Description in #{locale}")
            end
          end
        end
      end

      it "copies name and description translations" do
        expect(subject.result.name).to eq(old.name)
        expect(subject.result.description).to eq(old.description)
      end

      it "name in all available locales" do
        I18n.available_locales.each do |locale|
          Mobility.with_locale(locale) do
            expect(subject.result.name).to eq("Name in #{locale}")
          end
        end
      end

      it "description in all available locales" do
        I18n.available_locales.each do |locale|
          Mobility.with_locale(locale) do
            expect(subject.result.description).to eq("Description in #{locale}")
          end
        end
      end
    end

    context "copies status" do
      it "copies status" do
        expect(subject.result.status).to eq(old.status)
      end
    end

    context "copies other" do
      before { old.update!(other: { foo: :bar }) }

      it "copies other" do
        expect(subject.result.reload.other).to eq(old.other)
        expect(subject.result.other).to eq({ "foo" => "bar" })
      end
    end

    context 'when ingredient has image and providing {copy_image: "full"}' do
      let!(:image) { create(:image, :with_attached_image) }
      let(:params) { { old:, current_user:, copy_image: "full" } }

      before { ingredient.image = image }

      it { expect(subject.result.image).to be_present }

      it { expect(subject.errors).to be_empty }

      it { expect { subject }.to change { Image.count }.by(1) }
      it { expect { subject }.to change { ActiveStorage::Blob.count }.by(1) }
      it { expect { subject }.to change { ActiveStorage::Attachment.count }.by(1) }

      it { expect(subject.result.image.url).not_to eq ingredient.image.url }

      it "has a different image" do
        new = subject.result
        ingredient.image.attached_image.blob.purge
        ingredient.image.attached_image.destroy!
        ingredient.image.destroy!
        ingredient.destroy!

        expect(new.image.url).to be_present
        expect(new.image.attached_image.blob).to be_present
      end
    end

    context 'when ingredient has image and providing {copy_image: "link"}' do
      let!(:image) { create(:image, :with_attached_image) }
      let(:params) { { old:, current_user:, copy_image: "link" } }

      before { ingredient.image = image }

      it { expect(subject.result.image).to be_present }

      it { expect(subject.errors).to be_empty }

      it { expect { subject }.not_to(change { Image.count }) }
      it { expect { subject }.not_to(change { ActiveStorage::Blob.count }) }
      it { expect { subject }.not_to(change { ActiveStorage::Attachment.count }) }

      it { expect(subject.result.image.url).to eq ingredient.image.url }
      it { expect(subject.result.image.id).to eq ingredient.image.id }
    end

    context 'when ingredient has image and providing {copy_image: "none"}' do
      let!(:image) { create(:image, :with_attached_image) }
      let(:params) { { old:, current_user:, copy_image: "none" } }

      before { ingredient.image = image }

      it { expect(subject.result.image).to be_nil }
      it { expect(subject.result.reload.image).to be_nil }

      it { expect { subject }.not_to(change { Image.count }) }
      it { expect { subject }.not_to(change { ActiveStorage::Blob.count }) }
      it { expect { subject }.not_to(change { ActiveStorage::Attachment.count }) }
    end

    context "when ingredient has image record associated but without actual blob attached" do
      let!(:image) { create(:image) }

      before { ingredient.image = image }

      it { expect(subject.result.image).not_to be_present }

      it { expect { subject }.not_to(change { Image.count }) }
      it { expect { subject }.not_to(change { ActiveStorage::Blob.count }) }
      it { expect { subject }.not_to(change { ActiveStorage::Attachment.count }) }
    end

    context "if image creation fails" do
      let!(:image) { create(:image, :with_attached_image) }
      let(:params) { { old:, current_user:, copy_image: "full" } }

      before do
        ingredient.image = image
        allow_any_instance_of(Image).to receive(:valid?).and_return(false)
        errors = ActiveModel::Errors.new(Image)
        errors.add(:image, :invalid)
        allow_any_instance_of(Image).to receive(:errors).and_return(errors)
      end

      it "does not create any record and returns errors" do
        expect { subject }.not_to(change { Image.count })
        expect(subject.errors).not_to be_empty
      end

      it { expect { subject }.not_to(change { Menu::Allergen.count }) }
      it { expect { subject }.not_to(change { ActiveStorage::Blob.count }) }
      it { expect { subject }.not_to(change { Menu::AllergensInDish.count }) }
      it { expect { subject }.not_to(change { ImageToRecord.count }) }
    end
  end
end
