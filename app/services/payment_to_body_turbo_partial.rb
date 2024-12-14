# frozen_string_literal: true

class PaymentToBodyTurboPartial < ApplicationService
  def initialize(payment)
    @payment = payment
  end

  def call
    partial =
      case [status, payment_method_id, payment_requisite_id, payment_method_type]
      in ['pending', nil, nil, _]
        'payments/payment_methods'
      in ['pending', String, nil, _]
        'payments/loading'
      in ['processing', String, String, 'card']
        'payments/payment_requisite'
      in ['processing', String, String, 'phone']
        'payments/payment_requisite'
      in ['processing', String, String, 'iban']
        'payments/payment_requisite'
      in ['processing', String, String, 'payment_account']
        'payments/payment_requisite'
      in ['expired', _, _, _]
        'payments/expired'
      in ['success', _, _, _]
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

  def payment_method_type
    payment[:payment_method_type]
  end
end
