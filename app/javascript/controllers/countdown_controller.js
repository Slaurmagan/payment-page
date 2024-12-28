import {Controller} from "@hotwired/stimulus"
import {post} from "@rails/request.js"

export default class extends Controller {
  static targets = ['countdown']

  static values = {
    endDate: String
  }

  connect() {
    this.createCountdown()
  }

  disconnect() {
    clearInterval(this.intervalId)
  }

  createCountdown() {
    this.intervalId = setInterval(() => {
      this.updateCountdown(this.countdownTarget)
    }, 1000);
    this.updateCountdown(this.countdownTarget); // Initial call to show the timer immediately
  }

  updateCountdown(target) {
    const now = new Date();
    const timeRemaining = Math.max(new Date(this.endDateValue) - now, 0);

    // Calculate minutes and seconds
    const minutes = Math.floor(timeRemaining / 1000 / 60);
    const seconds = Math.floor((timeRemaining / 1000) % 60);

    // Format as mm:ss
    const formattedTime = `${String(minutes).padStart(2, '0')}:${String(seconds).padStart(2, '0')}`;

    target.textContent = formattedTime;

    // Stop countdown when time reaches zero
    if (timeRemaining === 0) {
      this.expire()
      clearInterval(this.intervalId);
    }
  }

  expire() {
    post(`${window.location.href}/expire`, {
      headers: {
        "Accept": "text/vnd.turbo-stream.html"
      },
      contentType: "application/json",
      responseKind: "turbo-stream"
    })
  }
}
