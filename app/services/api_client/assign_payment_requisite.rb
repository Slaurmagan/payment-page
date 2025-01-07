# frozen_string_literal: true

module ApiClient
  class AssignPaymentRequisite < Base
    post!

    def initialize(payment_id)
      @payment_id = payment_id
    end

    def call
      send_request
    end

    private

    attr_reader :payment_id

    def url
      "#{ENV['BACKEND_API_V2_URL']}/payments/#{payment_id}/assign_payment_requisite"
    end

    def body
      {}
    end
  end
end
