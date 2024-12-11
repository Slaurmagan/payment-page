# frozen_string_literal: true

class PaymentToHeaderTurboPartial < ApplicationService
  def initialize(payment)
    @payment = payment
  end

  def call
    partial =
      case [status, payment_method_id, payment_requisite_id]
      in ['pending', String, nil]
        'payments/loading_header'
      in ['processing', String, String]
        'payments/payment_requisite_header'
      in ['success', _, _]
        'payments/success_header'
      in ['expired', _, _]
        'payments/expired_header'
      else
        'payments/payment_methods_header'
      end

    ['payment_header', partial]
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
