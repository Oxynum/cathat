Cathat::Application.routes.draw do
  devise_for :users
  devise_scope :user do
    root :to => "pages#home"
  end
  resources :messages
  match 'update_position', to: 'users#update_position', via: :put
end
