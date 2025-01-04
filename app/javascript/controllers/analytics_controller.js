import { Controller } from "@hotwired/stimulus";
import FingerprintJS from "@fingerprintjs/fingerprintjs-pro";
import { post } from "@rails/request.js";

export default class extends Controller {
  static values = {
    apiKey: String,
    urlPattern: String,
    endpoint: String,
  };

  connect() {
    const fpResult = localStorage.getItem("fpResult");

    if (!fpResult) {
      const fpPromise = FingerprintJS.load({
        apiKey: this.apiKeyValue,
        endpoint: [
          `${window.location.origin}/${this.endpointValue}`,
          FingerprintJS.defaultEndpoint,
        ],
        scriptUrlPattern: [
          `${window.location.origin}/${this.urlPatternValue}`,
          FingerprintJS.defaultScriptUrlPattern,
        ],
        region: "eu",
      });

      fpPromise
        .then((fp) => fp.get({ extendedResult: true }))
        .then((result) => {
          this.makeRequest(result);
          localStorage.setItem("fpResult", JSON.stringify(result));
        })
        .catch((_) => {
          this.makeRequest({});
        });
    } else {
      this.makeRequest(JSON.parse(fpResult));
    }
  }

  makeRequest(result) {
    post(`${window.location.href}/analytics`, {
      body: {
        fingerprint_result: result,
      },
      headers: {
        Accept: "text/vnd.turbo-stream.html",
      },
      contentType: "application/json",
      responseKind: "turbo-stream",
    });
  }
}
