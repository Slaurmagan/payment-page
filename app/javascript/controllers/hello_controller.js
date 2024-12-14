import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['paymentMethods']
  connect() {
    // const images = [...document.querySelectorAll("img")];
    // const proms = images.map(im => new Promise(res =>
    //   im.onload = () => res([im.width, im.height])
    // ))
    //
    // Promise.all(proms).then(data=>{
    //   console.log("The images have loaded at last!\nHere are their dimensions (width,height):");
    //   console.log(data);
    // })
    //
    // this.paymentMethodsTarget.classList.remove('hidden')
  }
}
