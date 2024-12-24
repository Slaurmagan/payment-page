import {Controller} from "@hotwired/stimulus"


export default class extends Controller {
  static values = {
    redirectIn: Number,
    redirectTo: String
  }

  connect() {
    setTimeout(() => {
      debugger
      window.location.href = this.redirectToValue;
    }, this.redirectInValue * 1000)
  }
}
