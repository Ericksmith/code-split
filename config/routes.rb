Rails.application.routes.draw do
  root :to => 'vrooms#index'
  resources :vrooms
  match "/party/:id", :to => 'vrooms#party', :as => :party, :via => :get

  # devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
