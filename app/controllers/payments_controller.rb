class PaymentsController < ApplicationController
  def show
    @payment = RedisPayment.fetch(params[:id])
  end

  def assign_payment_method
    response = ApiClient::AssignPaymentMethod.call(params[:id], params[:payment_method_code])

    if response.success?
      respond_to do |format|
        format.turbo_stream {
          render turbo_stream: [
            turbo_stream.action('replaceWithSlideAnimation', 'payment_body', partial: 'payments/loading', locals: { payment: response.value!, with_animation: true }),
            turbo_stream.action('replaceWithSlideAnimation', 'payment_header', partial: 'payments/loading_header', locals: { payment: response.value!, with_animation: true })
          ]
        }
      end
    end
  end
end
