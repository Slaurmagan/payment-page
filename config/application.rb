require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module PaymentPage
  class Application < Rails::Application
    config.load_defaults 7.1

    config.autoload_lib(ignore: %w(assets tasks))
    config.autoload_paths += Dir.glob("#{config.root}/app/components")

    config.kafka_bootstrap_servers = ENV.fetch('KAFKA_BOOTSTRAP_SERVERS', 'kafka:9093')
    config.health_check_port = ENV.fetch('APP_PORT', 3000)
    config.app_name = ENV.fetch('APP_NAME', 'payment-page')
    config.client_id = ENV.fetch('KAFKA_CLIENT', 'payment-page')
    config.kafka_group = ENV.fetch('KAFKA_APP_NAME', 'payment-page')
    config.kafka_username = ENV.fetch('KAFKA_SASL_USERNAME', nil)
    config.kafka_password = ENV.fetch('KAFKA_SASL_PASSWORD', nil)
  end
end
