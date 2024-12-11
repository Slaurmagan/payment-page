class PaymentBroadcastHelper
  include Singleton

  class << self
    def loading(id)
      str = { status: 'pending', payment_method_id: 'fsdfsdf', id: }
      PaymentMessageProcessor.process(str)
    end

    def payment_methods(id)
      str = { status: 'pending', id: }
      PaymentMessageProcessor.process(str)
    end

    def payment_requisite(id)
      str = { status: 'processing', payment_method_id: 'fsdf', payment_requisite_id: 'dfgfdg', requisite: '4444 1111 2222 3333', amount: 3000, currency: 'R', id:, expires_at: 5.minutes.since }
      PaymentMessageProcessor.process(str)
    end

    def success(id)
      str = { status: 'success', id: }
      PaymentMessageProcessor.process(str)
    end

    def expired(id)
      str = { status: 'expired', id: }
      PaymentMessageProcessor.process(str)
    end
  end

end
