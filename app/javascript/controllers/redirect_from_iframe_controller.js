import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    if (window.self !== window.top) {
      window.open(window.location.href, '_blank');

      window.top.location = 'about:blank'; // Or redirect it elsewhere
    }
  }
}
