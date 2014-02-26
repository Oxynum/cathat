Cathat::Application.routes.draw do
  devise_for :users, controllers: { sessions: "users/sessions", registrations: "users/registrations", :omniauth_callbacks => "users/omniauth_callbacks"  }
  devise_scope :user do
    root :to => "pages#home"
  end
  resources :messages, only: :index
  resources :users, only: [:update, :index, :show] do 
  	resources :channels, only: [:create, :destroy]
  end
  resources :channels, except: [:new, :edit] do 
  	resources :users, only: [:create, :destroy]
  end
  get '/api/*path', to: 'api#get', defaults: { format: 'json' }
  match '/*path' => 'application#cors_preflight_check', :via => :options
end
