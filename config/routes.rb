Cathat::Application.routes.draw do
  devise_for :users, controllers: { registrations: "users/registrations", :omniauth_callbacks => "users/omniauth_callbacks"  }
  devise_scope :user do
    root :to => "pages#home"
  end
  resources :messages
  match 'update_position', to: 'users#update_position', via: :put
  match 'connected_users', to: 'users#connected', via: :get
end
