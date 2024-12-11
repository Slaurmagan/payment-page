# frozen_string_literal: true

class PaymentToBodyTurboPartial < ApplicationService
  def initialize(payment)
    @payment = payment
  end

  def call
    partial =
      case [status, payment_method_id, payment_requisite_id]
      in ['pending', nil, nil]
        'payments/payment_methods'
      in ['pending', String, nil]
        'payments/loading'
      in ['processing', String, String]
        'payments/payment_requisite'
      in ['expired', _, _]
        'payments/expired'
      in ['success', _, _]
        'payments/success'
      else
        'payments/error'
      end

    ['payment_body', partial]
  end

  private

  attr_reader :payment

  def status
    payment[:status]
  end

  def payment_method_id
    payment[:payment_method_id]
  end

  def payment_requisite_id
    payment[:payment_requisite_id]
  end
end
