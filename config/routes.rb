Rails.application.routes.draw do
  get 'up' => 'rails/health#show', as: :rails_health_check

  resources :payments, only: :show do
    member do
      post :assign_payment_method
      post :cancel
      post :cached_payment
      post :cached_payment_support
      post :analytics
      post :expire
      get :support
      post :create_ticket
    end
  end
end
