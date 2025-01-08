# frozen_string_literal: true

class PaymentToHeaderTurboPartial < ApplicationService
  def initialize(payment)
    @payment = payment
  end

  def call
    partial =
      case [status, payment_method_id, payment_requisite_id, payment_method_type]
      in ['pending', String, nil, _]
        'payments/loading_header'
      in ['processing', String, String, 'sberbank_deeplink']
        'payments/sberbank_deeplink_header'
      in ['processing', String, String, _]
        'payments/payment_requisite_header'
      in ['success', _, _, _]
        'payments/success_header'
      in ['expired', _, _, _]
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

  def payment_method_type
    payment[:payment_method_type]
  end

  def payment_requisite_id
    payment[:payment_requisite_id]
  end
end
