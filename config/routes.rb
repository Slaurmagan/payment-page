Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  mount ActionCable.server => '/cable'

  resources :payments, only: :show do
    member do
      post :assign_payment_method
      post :cancel
    end
  end
end
