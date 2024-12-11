module ApplicationCable
  class Channel < ActionCable::Channel::Base
    def subscribed
      logger.info "Client subscribed to: #{stream_name}"
      super
    end
  end
end
