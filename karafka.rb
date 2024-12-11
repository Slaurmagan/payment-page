# frozen_string_literal: true

class KarafkaApp < Karafka::App
  setup do |config|
    kafka_config = {
      'bootstrap.servers': Rails.application.config.kafka_bootstrap_servers
    }

    if Rails.env.production?
      base_config = { 'security.protocol': 'PLAINTEXT' }
      security_config = { 'security.protocol': 'SASL_SSL',
                          'sasl.mechanisms': 'SCRAM-SHA-512',
                          'sasl.username': Rails.application.config.kafka_username,
                          'sasl.password': Rails.application.config.kafka_password }

      if ENV['KAFKA_SSL']
        kafka_config.merge!(security_config)
      else
        kafka_config.merge!(base_config)
      end
    end

    config.kafka = kafka_config
    config.client_id = Rails.application.config.client_id
  end

  Karafka.monitor.subscribe(
    Karafka::Instrumentation::LoggerListener.new(
      log_polling: false
    )
  )

  Karafka.producer.monitor.subscribe(
    WaterDrop::Instrumentation::LoggerListener.new(
      Karafka.logger,
      log_messages: false
    )
  )

  require 'karafka/instrumentation/vendors/kubernetes/liveness_listener'
  listener = ::Karafka::Instrumentation::Vendors::Kubernetes::LivenessListener.new(
    hostname: '0.0.0.0',
    port: Rails.application.config.health_check_port,
    polling_ttl: 300_000,
    consuming_ttl: 60_000
  )
  Karafka.monitor.subscribe(listener)

  routes.draw do
    topic 'paymentPage.payments' do
      consumer PaymentConsumer
    end
  end
end
