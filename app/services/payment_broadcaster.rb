# frozen_string_literal: true

module PaymentBroadcaster
  # Accepts
  # { target: 'partial' }
  def broadcast(partials, stream_name, **opts)
    partials.each do |target, partial|
      Turbo::StreamsChannel.broadcast_action_later_to stream_name, partial:, target:, **opts.slice(:action, :locals)
    end
  end
end
