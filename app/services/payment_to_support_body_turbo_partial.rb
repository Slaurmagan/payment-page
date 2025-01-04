# frozen_string_literal: true

class PaymentToSupportBodyTurboPartial < ApplicationService
  def initialize(payment)
    @payment = payment
  end

  def call
    partial =
      case [support_request_id, support_request_status]
      in [nil, _]
        'payments/support/form'
      in [String, 'created']
        'payments/support/active'
      in [String, 'approved']
        'payments/support/approved'
      in [String, 'declined']
        'payments/support/declined'
      end

    ['payment_body', partial]
  end

  private

  attr_reader :payment

  def support_request_id
    payment[:support_request_id]
  end

  def support_request_status
    payment[:support_request_status]
  end
end
