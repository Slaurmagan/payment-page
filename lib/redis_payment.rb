class RedisPayment
  include Singleton

  class << self
    def fetch(id)
      val = $redis.get("payment_page:payments:#{id}").presence || '{}'
      JSON.parse(val).with_indifferent_access rescue {}
    end
  end
end
