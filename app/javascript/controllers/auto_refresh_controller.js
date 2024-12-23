import {Controller} from "@hotwired/stimulus"
import {post} from '@rails/request.js'

export default class extends Controller {
  static values = {
    frequency: Number,
    path: String,
    hash: String
  }
  
  connect() {
    this.intervalId = setInterval(() => {
      post(
        `${window.location.href}/${this.pathValue}`,
        {
          body: {
            hash: this.hashValue,
          },
          headers: {
            'Accept': "text/vnd.turbo-stream.html",
          },
          contentType: 'application/json',
          responseType: 'turbo-stream'
        }
      )
    }, this.frequencyValue * 1000);
  }

  disconnect() {
    clearInterval(this.intervalId);
  }
}
