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
    body_partial = PaymentToBodyTurboPartial.call(payment)
    header_partial = PaymentToHeaderTurboPartial.call(payment)
    broadcast([body_partial, header_partial], stream_name, locals: { payment:, with_animation: true }, action: 'replaceWithSlideAnimation')
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
