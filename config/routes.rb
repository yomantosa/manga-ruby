Rails.application.routes.draw do
  
  get 'sessions/new'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_for :users
  # users controller
  resources :users do
    get "posts" => "users#my_posts", :as => 'user_posts'
  end
  
  
  # posts controller
  resources :posts

  root "posts#index"
end
