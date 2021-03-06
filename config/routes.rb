Rails.application.routes.draw do

  root :to => 'rooms#index'
  resources :rooms, only: [:index, :create, :destory, :show, :destroy]


  devise_for :users
  mount ActionCable.server => '/cable'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
