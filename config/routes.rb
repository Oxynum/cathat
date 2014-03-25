SuperCat::Application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, controllers: { sessions: "users/sessions", registrations: "users/registrations"}
  resources :messages, only: [:index, :create, :show, :update]
  resources :users, only: [:update, :index, :show] do 
  	resources :channels, only: [:create, :destroy]
  end
  resources :channels, except: [:new, :edit], shallow: true do 
  	resources :users, only: [:create, :destroy]
  end
  get '/api/*path', to: 'api#get', defaults: { format: 'json' }
  match '/*path' => 'application#cors_preflight_check', :via => :options
  match '/auth/:provider/callback', to: 'omniauth/sessions#create', via: [:get, :post]
end