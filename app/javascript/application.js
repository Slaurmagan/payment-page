// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "./controllers"
import {Turbo} from "@hotwired/turbo-rails"
//
Turbo.StreamActions.console_log = function () {
  const method = this.getAttribute("method");
  this.targetElements.forEach((targetElement => {
    if (method === "morph") {
      morphElements(targetElement, this.templateContent);
    } else {
      targetElement.replaceWith(this.templateContent);
    }
  }));
}


Turbo.StreamActions.replaceWithSlideAnimation = function () {
  const method = this.getAttribute("method");
  const withAnimation = this.templateContent.querySelector('turbo-frame').dataset.withAnimation === 'true'

  this.targetElements.forEach((targetElement => {
    if (method === "morph") {
      morphElements(targetElement, this.templateContent);
    } else {
      if (withAnimation) {
        console.log('animation started')
        targetElement.firstElementChild.classList.remove('slide-in', 'out-of-screen')
        targetElement.firstElementChild.classList.add('slide-out')
        setTimeout(() => {
          targetElement.replaceWith(this.templateContent);
          setTimeout(() => {
            document.getElementById(this.getAttribute('target')).firstElementChild.classList.add('slide-in')
          }, 100)
        }, 500)
      } else {
        targetElement.replaceWith(this.templateContent);
      }
    }
  }));
}


document.addEventListener('DOMContentLoaded', () => {
  console.log('sdfsdf')
})
