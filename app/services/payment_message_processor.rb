# frozen_string_literal: true

class PaymentMessageProcessor < ApplicationService
  include PaymentBroadcaster

  class << self
    alias process call
  end

  def initialize(raw_payload)
    @raw_payload = raw_payload
  end

  def call
    broadcast(
      [
        %w[payment_body payments/payment/body/body],
        %w[payment_header payments/payment/header/header]
      ], stream_name, locals: { payment:, with_animation: true }, action: 'replaceWithSlideAnimation')
  end

  private

  attr_reader :raw_payload

  def decode_payment
    JSON.parse(raw_payload)
  end

  def payment
    @decoded_payment ||= decode_payment.with_indifferent_access
  end

  def stream_name
    "payments_#{payment[:id]}"
  end
end
