Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'books#index'
  get 'books/find', as: 'books_find'
  get '/info/:info', to: 'books#info', as: 'find_info'
  get '/mypage', to: 'books#mypage', as: 'mypage'
  get '/mypage/mybook', to: 'books#mybook', as: 'mybook'
  get '/mypage/myzzim', to: 'books#myzzim', as: 'myzzim'
  get '/hello', to: 'books#introduction', as: 'intro'
  get '/sgmail', to: 'books#sgmail', as: 'sgmail'

  resources :books do
  	post '/like', to: 'books#like_toggle'
    post '/sell', to: 'books#sell'
    resources :comments, only: [:create, :destroy, :edit, :update] do
      resources :replies, only: [:new, :create, :destroy, :edit, :update]
    end
  end
  resources :conversations, only: [:create] do
  	member do
  		post :close
  	end
  	resources :messages, only: [:create]
  end
  get '/new_notifications/read_all' => 'new_notifications#read_all'
  resources :new_notifications
end
