FbGh::Application.routes.draw do
  devise_for :users
  get "/callback/:provider" => "authentications#create"
  get "/auth/failure" => "authentications#failure"
  resources :authentications
  resources :meetups
  match "/me" => "users#show"
  resources :users
  root :to => 'title#welcome'
end
