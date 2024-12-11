# frozen_string_literal: true

$redis =
  if Rails.env.development? || Rails.env.test?
    Redis.new(
      url: ENV.fetch('REDIS_URL', 'redis://redis:6379/0')
    )
  else
    Redis.new(
      url: ENV.fetch('REDIS_URL', 'redis://redis:6379/0'),
      password: ENV.fetch('REDIS_PASS', 'redis-pass')
    )
  end
