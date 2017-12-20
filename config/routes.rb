Rails.application.routes.draw do
  root to: "editors#index"
  
  resources :editors, only: [:show]
  resources :rooms, only: [:index, :create, :destory, :show]

  devise_for :users
  mount ActionCable.server => '/cable'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
