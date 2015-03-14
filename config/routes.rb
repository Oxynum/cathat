SuperCat::Application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, controllers: { sessions: "users/sessions", registrations: "users/registrations", passwords: "users/passwords"}
  resources :messages, only: [:index, :show, :update]
  resources :users, only: [:update, :index, :show] do 
  	resources :channels, only: [:create, :destroy]
  end
  resources :channels, except: [:new, :edit], shallow: true do 
  	resources :users, only: [:create, :destroy, :index]
    resources :messages, only: :create
  end
  get '/api/*path', to: 'api#get', defaults: { format: 'json' }
  match '/*path' => 'application#cors_preflight_check', :via => :options
  match '/auth/:provider/callback', to: 'omniauth/sessions#create', via: [:get, :post]
end