# # frozen_string_literal: true

module ApiClient
  class Fingerprint < Base
    post!

    def initialize(payment_id, params)
      @payment_id = payment_id
      @params = params.to_unsafe_hash
    end

    def call
      response = send_request

      return Failure() unless response.success?

      json_response = JSON.parse(response.body).with_indifferent_access

      Success(json_response['payment'])
    end

    private

    attr_reader :payment_id, :params

    def url
      "#{ENV['BACKEND_API_V2_URL']}/antifraud"
    end

    def body
      {
        visit_data: params[:meta],
        fingerprint: params[:visitorId],
        payment_id: payment_id
      }
    end
  end
end
