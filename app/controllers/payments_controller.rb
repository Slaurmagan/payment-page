class PaymentsController < ApplicationController
  before_action :find_payment

  def show; end

  def assign_payment_method
    return if @payment[:payment_method_id].present?

    response = ApiClient::AssignPaymentMethod.call(params[:id], params[:payment_method_code])

    return unless response.success?

    payment = response.value!
    render_payment(payment)
  end

  def expire
    return if @payment[:status] == 'expired'

    response = ApiClient::Expire.call(params[:id])

    return unless response.success?

    payment = response.value!
    render_payment(payment)
  end

  def cancel
    return if @payment[:status] == 'expired'

    response = ApiClient::CancelPayment.call(params[:id])

    return unless response.success?

    payment = response.value!
    render_payment(payment)
  end

  def cached_payment
    unless @payment[:hash] != params[:hash]
      head :ok, content_type: 'text/vnd.turbo-stream.html'
      return
    end

    render_payment(@payment)
  end

  def analytics
    unless @payment[:fingerprint]
      head :ok, content_type: 'text/vnd.turbo-stream.html'
      return
    end

    response = ApiClient::Fingerprint.call(params[:id], params[:fingerprint_result])

    render_payment(response.value!)
  end

  private

  def find_payment
    @payment = RedisPayment.fetch(params[:id])
  end

  def render_payment(payment, action: 'replaceWithSlideAnimation')
    body = PaymentToBodyTurboPartial.call(payment)
    header = PaymentToHeaderTurboPartial.call(payment)
    to_render = [body, header]

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: to_render.map { |target, partial|
          turbo_stream.action(action, target, partial:, locals: { payment:, with_animation: true })
        }
      end
    end
  end
end
