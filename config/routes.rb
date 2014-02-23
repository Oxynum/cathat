Cathat::Application.routes.draw do
  devise_for :users, controllers: { sessions: "users/sessions", registrations: "users/registrations", :omniauth_callbacks => "users/omniauth_callbacks"  }
  devise_scope :user do
    root :to => "pages#home"
  end
  resources :messages, only: :index
  resources :users, only: [:update, :index]
  get '/api/*path', to: 'api#get', defaults: { format: 'json' }
end
