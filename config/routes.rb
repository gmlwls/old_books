Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'books#index'
  resources :books do
  	post '/like', to: 'books#like_toggle'
  end
end
