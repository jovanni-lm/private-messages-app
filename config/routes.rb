Rails.application.routes.draw do
  get 'users/index'

  # devise_for :users, controllers: {
  #     sessions: 'users/sessions'
  # }

  devise_for :users
  devise_scope :user do
    get '/login' => 'devise/sessions#new'
    get '/logout' => 'devise/sessions#destroy'

    get 'sign_in', to: 'devise/sessions#new'
    authenticated :user do
      root :to => 'users#index'
    end
    unauthenticated :user do
      root :to => 'devise/sessions#new', as: :unauthenticated_root
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # authenticated :user do
  #   root to: 'users#index', as: :authenticated_root
  # end
  #
  # root 'users/sessions#new'

  # match '/users/:id', to: 'users#show', as: :user, via: :get

  resources :users
  resources :messages, only: [:new, :create]
end
