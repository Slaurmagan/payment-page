# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "@hotwired--stimulus.js" # @3.2.2
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin "@rails/request.js", to: 'https://cdn.jsdelivr.net/npm/@rails/request.js@0.0.11/dist/requestjs.min.js'
pin_all_from "app/javascript/controllers", under: "controllers"
pin "@stimulus-components/clipboard", to: "@stimulus-components--clipboard.js" # @5.0.0
