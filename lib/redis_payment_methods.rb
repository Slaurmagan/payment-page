class RedisPaymentMethods
  include Singleton

  class << self
    def fetch
      Rails.cache.read('payment_page:payment_methods').presence || []
    end
  end
end
