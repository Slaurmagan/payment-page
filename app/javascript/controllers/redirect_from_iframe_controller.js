import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    console.log('checking if in iframe')
    if (window.self !== window.top) {
      console.log('iframe opened')
      window.open(window.location.href, '_blank');

      window.top.location = 'about:blank'; // Or redirect it elsewhere
    }
  }
}
