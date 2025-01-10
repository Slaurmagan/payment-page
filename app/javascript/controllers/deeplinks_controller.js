import {Controller} from "@hotwired/stimulus"


export default class extends Controller {
  static values = {
    links: Object
  }

  open() {
    console.log('clicked')
    const links = this.linksValue[this.getMobileOperatingSystem()]

    if (links) {
      links.forEach((link, idx) => {
        setTimeout(() => {
          window.location.href = link;
        }, idx * 1000);
      });
    }
  }

  getMobileOperatingSystem() {
    var userAgent = navigator.userAgent || navigator.vendor || window.opera;

    if (/android/i.test(userAgent)) {
      return "android";
    }

    // iOS detection from: http://stackoverflow.com/a/9039885/177710
    if (/iPad|iPhone|iPod/.test(userAgent) && !window.MSStream) {
      return "ios";
    }

    return "unknown";
  }

  isMobile() {
    const regex = /Mobi|Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i;
    return regex.test(navigator.userAgent);
  }
}
