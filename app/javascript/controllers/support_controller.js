import {Controller} from "@hotwired/stimulus"
import Uppy from '@uppy/core'
import Dashboard from '@uppy/dashboard'
import {ThumbnailGenerator} from "uppy";
import Russian from '@uppy/locales/lib/ru_RU'
import XHRUpload from '@uppy/xhr-upload'

export default class extends Controller {
  static targets = ['dashboard']

  connect() {
    this._uppy?.close()

    this._uppy = new Uppy({
      autoProceed: false,
      restrictions: {
        maxFileSize: 5242880, // 5 mb
        minFileSize: 0,
        minNumberOfFiles: 1,
        maxNumberOfFiles: 3,
        allowedFileTypes: ['.pdf']
      },
      locale: Russian,
    }).use(Dashboard, {
      target: this.dashboardTarget,
      inline: true,
      height: 200,
      width: 300,
    }).use(ThumbnailGenerator, {
      thumbnailWidth: 55,
      thumbnailHeight: 55
    }).use(XHRUpload, {
      endpoint: `${window.location.href.replace('/support', '')}/create_ticket`,
      headers: {
        'X-Csrf-Token': document.querySelector("meta[name='csrf-token']").getAttribute("content")
      },
      bundle: true,
      async onAfterResponse(xhr) {
        Turbo.renderStreamMessage(xhr.response)
      }
    })
  }


  submit() {
    this._uppy.upload().then(res => console.log(res))
  }
}
