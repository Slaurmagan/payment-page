# frozen_string_literal: true

class PaymentMethodComponent < ViewComponent::Base
  def initialize(payment_method:)
    @payment_method = payment_method
  end

  def render?
    enabled? && @payment_method[:image_url].present? && @payment_method[:displayed_name].present? && @payment_method[:id].present?
  end

  def enabled?
    @payment_method[:enabled].presence || false
  end
end
