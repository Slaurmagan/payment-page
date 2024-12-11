# frozen_string_literal: true

require 'dry/monads/do'

module ApiClient
  class Base < ApplicationService
    include Dry::Monads[:result]
    include Dry::Monads::Do.for(:call)

    POST = :POST
    GET = :GET
    PATCH = :PATCH

    class << self
      def post!
        define_method :request_type do
          POST
        end
      end

      def patch!
        define_method :request_type do
          PATCH
        end
      end
    end

    def call
      Oj.load(response.body)
    end

    private

    attr_reader :params

    def request_type
      GET
    end

    def send_request
      case request_type
      when GET
        get_request
      when POST
        post_request
      when PATCH
        patch_request
      else
        raise "Unknown request method #{request_type}"
      end
    end

    def get_request
      HTTParty.get(
        url,
        headers:,
        )
    end

    def post_request
      HTTParty.post(
        url,
        body: body.to_json,
        headers:,
        timeout: 30,
        verify: verify_ssl
      )
    end

    def verify_ssl
      true
    end

    def patch_request
      HTTParty.patch(
        url,
        body: body.to_json,
        headers:,
        )
    end

    def body
      raise NotImplementedError
    end

    def headers
      {
        'Content-Type' => 'application/json'
      }
    end
  end
end
