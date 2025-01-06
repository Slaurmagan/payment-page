class RedisPayment
  include Singleton

  class << self
    def fetch(id)
      val = $redis.get("payment_page:payments:#{id}").presence || "x\x9C\xAB\xAE\x05\x00\x01u\x00\xF9"

      JSON.parse(Zlib.inflate(val)).with_indifferent_access rescue {}
    end
  end
end
