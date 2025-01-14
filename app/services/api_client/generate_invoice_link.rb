# frozen_string_literal: true

module ApiClient
  class GenerateInvoiceLink < Base
    post!

    def initialize(payment_id)
      @payment_id = payment_id
    end

    def call
      response = send_request

      return Failure() unless response.success?

      json_response = JSON.parse(response.body).with_indifferent_access
      Success(json_response['payment'])
    end

    private

    attr_reader :payment_id

    def url
      "#{ENV['BACKEND_API_V2_URL']}/payments/#{payment_id}/generate_invoice_link"
    end

    def body
      {}
    end
  end
end
