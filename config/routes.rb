Rails.application.routes.draw do
  get 'up' => 'rails/health#show', as: :rails_health_check

  resources :payments, only: :show do
    member do
      # Payments
      post :assign_payment_method
      post :cancel
      post :cached_payment
      post :analytics
      post :expire
      post :requisite

      # Support
      post :create_ticket
      post :cached_payment_support
      get :support
    end
  end
end
