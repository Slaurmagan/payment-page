class RedisPaymentMethods
  include Singleton

  class << self
    def fetch
      JSON.parse($redis.get('payment_page:payment_methods').presence || '[]')
    end
  end
end
