Rails.application.routes.draw do
  devise_for :users
  root :to => 'homes#top'
  get "/home/about" => "homes#about", as:"home_about"
  resources :books do
    resource :favorites, only: [:create, :destroy]
    resources:book_comments, only: [:create, :destroy]
  end
  resources :users
  post 'follow/:id' => 'relationships#follow', as: 'follow' # フォローする
  post 'unfollow/:id' => 'relationships#unfollow', as: 'unfollow' # フォロー外す
  get '/users/:id/following(.:format)' => 'users#following', as: 'following_user'
  get '/users/:id/followers(.:format)' => 'users#followers', as: 'followers_user'

  get 'search' => 'searches#search'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
