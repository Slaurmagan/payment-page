# frozen_string_literal: true

class PaymentToSupportHeaderTurboPartial < ApplicationService
  def initialize(payment)
    @payment = payment
  end

  def call
    partial =
      case [support_request_id, support_request_status]
      in [nil, _]
        'payments/support/form_header'
      in [String, 'created']
        'payments/support/active_header'
      in [String, 'approved']
        'payments/support/approved_header'
      in [String, 'declined']
        'payments/support/declined_header'
      end

    ['payment_header', partial]
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
