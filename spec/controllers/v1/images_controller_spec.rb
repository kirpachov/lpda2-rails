# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::ImagesController, type: :controller do
  include_context CONTROLLER_UTILS_CONTEXT
  # include_context CONTROLLER_AUTHENTICATION_CONTEXT
  include_context TESTS_OPTIMIZATIONS_CONTEXT

  let(:instance) { described_class.new }

  context '#download' do
    it { expect(instance).to respond_to(:download) }
    it { should route(:get, '/v1/images/23/download').to(format: :json, action: :download, controller: 'v1/images', id: 23) }

    let(:image) { create(:image, :with_attached_image) }

    def req(image_id, params = {})
      get :download, params: params.merge(id: image_id)
    end

    it 'should return 200' do
      req(image.id)
      expect(response).to have_http_status(200)
    end

    it 'should return 404 if cannot find image' do
      req(999_999_999)
      expect(response).to have_http_status(404)
    end

    context 'when has no :attached_image' do
      it 'should return 500' do
        image.attached_image.purge
        req(image.id)
        expect(response).to have_http_status(500)
      end
    end

    context 'when errors on download, should return 500 with message' do
      before do
        allow_any_instance_of(Image).to receive(:download).and_raise(ActiveStorage::FileNotFoundError)
        req(image.id)
      end

      it { expect(response).to have_http_status(500) }
      it { expect(parsed_response_body).to include(message: String) }
    end
  end

  context '#download_variant' do
    it { expect(instance).to respond_to(:download_variant) }
    it { should route(:get, '/v1/images/23/download/blur').to(format: :json, action: :download_variant, controller: 'v1/images', id: 23, variant: 'blur') }
    let(:image) { create(:image, :with_attached_image) }

    def req(image_id, variant, params = {})
      get :download_variant, params: params.merge(id: image_id, variant:)
    end

    context 'should generate "blur" variant runtime' do
      before { image.blur_image&.destroy! }

      it do
        expect { req(image.id, 'blur') }.to change { image.reload.blur_image.present? }.from(false).to(true)
      end

      it do
        expect { req(image.id, 'blur') }.to change { Image.where(tag: 'blur').count }.by(1)
      end
    end

    context 'when variant is not found' do
      it 'should return 404' do
        req(image.id, 'impossible_variant')
        expect(response).to have_http_status(404)
      end
    end

    context 'when has no :attached_image' do
      it 'should return 500' do
        image.generate_image_variants!
        image.blur_image.attached_image.purge
        req(image.id, 'blur')
        expect(response).to have_http_status(500)
      end
    end
  end
end