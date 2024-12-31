import { Controller } from "@hotwired/stimulus";
import ClipboardJS from "clipboard";

export default class extends Controller {
  static targets = ['button']

  static values = {
    copiedMessage: String,
    textToCopy: String,
    buttonSelector: String,
  };

  connect() {
    this.clipboard = new ClipboardJS(this.buttonSelectorValue);

    this.clipboard.on("success", function () {
      const initialText = this.buttonTarget.innerText;
      this.buttonTarget.innerText = this.copiedMessageValue;

      setTimeout(() => {
        this.buttonTarget.innerText = initialText;
      }, 3000);
    }.bind(this));
  }

  disconnect() {
    this.clipboard.destroy();
  }
}
