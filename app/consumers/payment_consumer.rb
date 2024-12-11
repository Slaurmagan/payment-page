# frozen_string_literal: true

class PaymentConsumer < ApplicationConsumer
  def consume
    messages.each do |message|
      PaymentMessageProcessor.process(message.raw_payload)
    end
  end
end
