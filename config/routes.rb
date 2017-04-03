Rails.application.routes.draw do
  get 'users/index'

  devise_for :users, controllers: { registrations: 'registrations' }
  devise_scope :user do
    authenticated :user do
      root to: 'users#index'
    end
    unauthenticated :user do
      root to: 'devise/sessions#new', as: :unauthenticated_root
    end
  end

  resources :users do
    get 'message_counter', on: :collection
  end

  resources :messages, only: [:new, :create]
end
