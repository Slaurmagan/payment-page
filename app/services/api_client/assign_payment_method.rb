# frozen_string_literal: true

module ApiClient
  class AssignPaymentMethod < Base
    post!

    def initialize(payment_id, payment_method_code)
      @payment_id = payment_id
      @payment_method_code = payment_method_code
    end

    def call
      response = send_request

      return Failure() unless response.success?

      json_response = JSON.parse(response.body).with_indifferent_access
      Success(json_response['payment'])
    end

    private

    attr_reader :payment_id, :payment_method_code

    def url
      "#{ENV['BACKEND_API_V2_URL']}/payments/#{payment_id}/assign_payment_method"
    end

    def body
      {
        payment_method_code:
      }
    end
  end
end
