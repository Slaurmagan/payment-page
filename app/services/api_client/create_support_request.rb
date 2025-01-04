# frozen_string_literal: true

module ApiClient
  class CreateSupportRequest < Base
    post!

    def initialize(payment_id, files)
      @payment_id = payment_id
      @files = files
    end

    def call
      response = send_request
      return Failure(response.body) unless response.success?

      json_response = JSON.parse(response.body).with_indifferent_access
      Success(json_response['payment'])
    end

    private

    attr_reader :payment_id, :files

    def url
      "#{ENV['BACKEND_API_V2_URL']}/support_requests"
    end

    def post_request
      HTTParty.post(
        url,
        body: body,
        headers:,
        timeout: 30,
        verify: verify_ssl
      )
    end

    def body
      {
        files:,
        payment_id:
      }
    end

    def headers
      {
        'Content-Type' => 'mutlipart/form-data'
      }
    end
  end
end
