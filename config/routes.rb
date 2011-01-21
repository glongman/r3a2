R3a2::Application.routes.draw do
  root :to => "home#index"
  devise_for :users  
  resources :users do
    member do
      get :lock, :action => 'show_lock'
      put :lock, :action => 'lock'
      delete :lock, :action => 'unlock'
    end
  end
end
