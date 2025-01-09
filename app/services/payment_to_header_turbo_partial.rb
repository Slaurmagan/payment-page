# frozen_string_literal: true

class PaymentToHeaderTurboPartial < ApplicationService
  def initialize(payment)
    @payment = payment
  end

  def call
    partial =
      case [status, payment_method_id, payment_requisite_id, payment_method_type]
      in ['pending', String, nil, _]
        'payments/payment/header/loading_header'
      in ['processing', String, String, 'sberbank_deeplink']
        'payments/payment/header/deeplink_header'
      in ['processing', String, String, 'tinkoff_deeplink']
        'payments/payment/header/deeplink_header'
      in ['processing', String, String, _]
        'payments/payment/header/payment_requisite_header'
      in ['success', _, _, _]
        'payments/payment/header/success_header'
      in ['expired', _, _, _]
        'payments/payment/header/expired_header'
      else
        'payments/payment/header/payment_methods_header'
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
