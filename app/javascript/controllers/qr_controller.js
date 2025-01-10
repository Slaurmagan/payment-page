import QRCode from 'qrcode'
import {Controller} from "@hotwired/stimulus"


export default class extends Controller {
  static targets = ['canvas']
  static values = {
    qrString: String
  }


  connect() {
    const str = this.qrStringValue || window.location.href

    QRCode.toCanvas(this.canvasTarget, str, () => {})
  }
}
