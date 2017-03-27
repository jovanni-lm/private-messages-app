Rails.application.routes.draw do
  get 'users/index'

  # devise_for :users, controllers: {
  #     sessions: 'users/sessions'
  # }

  devise_for :users
  devise_scope :user do
    authenticated :user do
      root :to => 'users#index'
    end
    unauthenticated :user do
      root :to => 'devise/registrations#new', as: :unauthenticated_root
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # authenticated :user do
  #   root to: 'users#index', as: :authenticated_root
  # end
  #
  # root 'users/sessions#new'

  match '/users/:id', to: 'users#show', as: :user, via: :get

  resource :messages
end
