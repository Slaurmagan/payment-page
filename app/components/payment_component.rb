# frozen_string_literal: true

class PaymentComponent < ViewComponent::Base

  renders_many :payment_methods, 'PaymentMethodComponent'

  def initialize(payment:)
    @payment = payment
  end
end
