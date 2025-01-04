class PaymentsController < ApplicationController
  before_action :find_payment

  def show
    response.headers['X-Frame-Options'] = 'ALLOWALL'
  end

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

  def support
    response.headers['X-Frame-Options'] = 'ALLOWALL'
  end

  def cached_payment_support
    unless @payment[:hash] != params[:hash]
      head :ok, content_type: 'text/vnd.turbo-stream.html'
      return
    end

    render_payment_support(@payment)
  end

  def create_ticket
    return if @payment.blank?
    return if @payment[:support_request_id].present?

    response = ApiClient::CreateSupportRequest.call(params[:id], params[:files].map(&:tempfile))

    return unless response.success?

    payment = response.value!
    render_payment_support(payment)
  end

  def analytics
    if @payment.blank? || @payment[:fingerprint].blank?
      head :ok, content_type: 'text/vnd.turbo-stream.html'
      return
    end

    response = ApiClient::Fingerprint.call(params[:id], params[:fingerprint_result])

    payment =
      if response.success?
        response.value!
      else
        response.failure
      end

    render_payment(payment)
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

  def render_payment_support(payment, action: 'replaceWithSlideAnimation')
    body = PaymentToSupportBodyTurboPartial.call(payment)
    header = PaymentToSupportHeaderTurboPartial.call(payment)
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
