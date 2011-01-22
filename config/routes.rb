R3a2::Application.routes.draw do
  root :to => "home#index"
  devise_for :users  
  resources :users do
    member do
      get :lock, :action => 'show_lock'
      put :lock, :action => 'lock'
      delete :lock, :action => 'unlock'
    end
    resources :players, :only =>[:index, :create], :controller => :players
  end
  resources :players, :except => [:new, :edit] do
    member do
      get :lock, :action => 'show_lock'
      put :lock, :action => 'lock'
      delete :lock, :action => 'unlock'
    end
    resources :scores, :only => [:index, :create]
    resources :scoresheets, :only => [:index]
    member do
      get :scoresheet, :controller => :scoresheets, :action => 'show'
    end
  end
  resources :scores, :except => [:create, :new, :edit]
  resources :scoresheets, :except => [:create, :new, :edit, :update]
end
