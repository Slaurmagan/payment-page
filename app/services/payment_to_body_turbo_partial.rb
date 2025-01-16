# frozen_string_literal: true

class PaymentToBodyTurboPartial < ApplicationService
  def initialize(payment)
    @payment = payment
  end

  def call
    partial =
      case [status, payment_method_id, payment_requisite_id, payment_method_type, fingerprint]
      in ['expired', _, _, _, _]
        'payments/payment/body/expired'
      in ['declined', _, _, _, _]
        'payments/payment/body/expired'
      in ['success', _, _, _, _]
        'payments/payment/body/success'
      in [_, _, _, _, true]
        'payments/payment/body/fingerprint'
      in ['pending', nil, nil, _, _]
        'payments/payment/body/payment_methods'
      in ['pending', String, nil, _, _]
        'payments/payment/body/loading'
      in ['processing', String, String, 'card', _]
        'payments/payment/body/payment_requisite'
      in ['processing', String, String, 'phone', _]
        'payments/payment/body/payment_requisite'
      in ['processing', String, String, 'iban', _]
        'payments/payment/body/payment_requisite'
      in ['processing', String, String, 'payment_account', _]
        'payments/payment/body/payment_requisite'
      in ['processing', String, String, 'sberbank_deeplink', _]
        'payments/payment/body/sberbank_deeplink_requisite'
      in ['processing', String, String, 'tinkoff_deeplink', _]
        'payments/payment/body/tinkoff_deeplink_requisite'
      in ['processing', String, _, 'redirect', _]
        'payments/payment/body/redirect_to_external_payment_page'
      else
        'payments/payment/body/error'
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

  def fingerprint
    payment[:fingerprint]
  end
end
