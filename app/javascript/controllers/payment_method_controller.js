import {Controller} from "@hotwired/stimulus"
import {post} from '@rails/request.js'

export default class extends Controller {
  click(e) {
    post(
      `${window.location.href}/assign_payment_method`,
      {
        body: {
          payment_method_code: e.currentTarget.dataset.paymentMethodCode
        },
        headers: {
          "Accept": "text/vnd.turbo-stream.html",
        },
        contentType: 'application/json',
        responseType: "turbo-stream"
      }
    )
  }
}
