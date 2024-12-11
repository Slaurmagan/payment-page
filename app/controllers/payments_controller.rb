class PaymentsController < ApplicationController
  def show
    @payment = RedisPayment.fetch(params[:id])
  end

  def assign_payment_method
    response = ApiClient::AssignPaymentMethod.call(params[:id], params[:payment_method_code])

    if response.success?
      payment = response.value!
      render_payment(payment)
    end
  end

  def cancel
    response = ApiClient::CancelPayment.call(params[:id])

    if response.success?
      payment = response.value!
      render_payment(payment)
    end
  end

  private

  def render_payment(payment)
    body = PaymentToBodyTurboPartial.call(payment)
    header = PaymentToHeaderTurboPartial.call(payment)
    to_render = [body, header]

    respond_to do |format|
      format.turbo_stream {
        render turbo_stream: to_render.map { |target, partial| turbo_stream.action('replaceWithSlideAnimation', target, partial:, locals: { payment:, with_animation: true }) }
      }
    end
  end
end
