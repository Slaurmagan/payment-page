class RedisPaymentMethods
  include Singleton

  class << self
    def fetch
      JSON.parse($redis.get('payment_page:payment_methods').presence || '[]')
    end

    def from_payment(payment)
      RedisPayment.fetch(payment['id'])['payment_methods'] || []
    end
  end
end
