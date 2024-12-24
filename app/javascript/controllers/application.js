import { Application } from "@hotwired/stimulus"
import HelloController from "./hello_controller";
import PaymentMethodController from "./payment_method_controller";
import CountdownController from "./countdown_controller";
import CancelController from "./cancel_controller";
import AutoRefreshController from "./auto_refresh_controller.js"

const application = Application.start()

application.register('hello', HelloController)
application.register('payment-method', PaymentMethodController)
application.register('countdown', CountdownController)
application.register('cancel', CancelController)
application.register('auto-refresh', AutoRefreshController)

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }
