# frozen_string_literal: true

class PaymentTheme < ApplicationService
  def initialize(payment)
    @payment = payment
  end

  def header_primary_color
    theme.dig(:header, :primary_color) || theme[:primary_color]
  end

  def body_primary_color
    theme.dig(:body, :primary_color) || theme[:primary_color]
  end

  def theme
    Theme::DEFAULT
  end
end
