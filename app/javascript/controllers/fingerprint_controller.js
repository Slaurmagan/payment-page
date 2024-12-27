import { Controller } from "@hotwired/stimulus"
import FingerprintJS from '@fingerprintjs/fingerprintjs-pro'
import {post} from "@rails/request.js"

export default class extends Controller {
  static values = {
    apiKey: String
  }

  connect() {
    const fpPromise = FingerprintJS.load({
      apiKey: this.apiKeyValue,
      region: "eu"
    })

    fpPromise.then(fp => fp.get()).then(result => {
      post(`${window.location.href}/fingerprint`, {
        body: {
          fingerprint_result: result
        },
        headers: {
          "Accept": "text/vnd.turbo-stream.html"
        },
        contentType: "application/json",
        responseKind: "turbo-stream"
      })
    })
  }
}
