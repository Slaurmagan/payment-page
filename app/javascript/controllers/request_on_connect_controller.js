import {Controller} from "@hotwired/stimulus"
import {post} from '@rails/request.js'

export default class extends Controller {
  static values = {
    path: String,
  }

  connect() {
    if (this.pathValue) {
      post(
        `${window.location.href}/${this.pathValue}`,
        {
          body: {},
          headers: {
            "Accept": "text/vnd.turbo-stream.html",
          },
          contentType: 'application/json',
          responseKind: "turbo-stream"
        }
      )
    }
  }
}
