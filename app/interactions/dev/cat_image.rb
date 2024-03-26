# frozen_string_literal: true

module Dev
  class CatImage < ActiveInteraction::Base
    class << self
      def create
        ::Image.create_from_url(url: run!.sample)
      end
    end

    validate :api_key_present
    integer :limit, default: 1

    # If nil, returns all information
    symbol :fetch, default: :url

    attr_reader :json

    def execute
      url = URI("https://api.thecatapi.com/v1/images/search?limit=#{limit.to_i}")

      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_PEER

      request = Net::HTTP::Get.new(url)
      request['Content-Type'] = 'application/json'
      request['Authorization'] = "x-api-key #{api_key}"
      # request.body = { limit: }.to_json

      response = http.request(request)

      @json = Oj.load(response.read_body).map(&:with_indifferent_access)

      @json.map { |j| j[fetch] }
    end

    private

    def api_key_present
      return if api_key.present?

      errors.add(:api_key, 'is required')
      errors.add(:base, <<~ERROR
        Api key is required to fetch cat images.
        You can get one from https://thecatapi.com/
        Once you got the key, add it to config/app.yml as 'cat_api_key'
      ERROR
      )
    end

    def api_key
      Config.app[:cat_api_key]
    end
  end
end
