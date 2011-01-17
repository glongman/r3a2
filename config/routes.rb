R3a2::Application.routes.draw do
  root :to => "home#index"
  devise_for :users  
  resources :users
end
