FbGh::Application.routes.draw do
  devise_for :users
  match "/auth/:provider/callback" => "authentications#create"
  resources :authentications
  resources :meetups
  get "/user" => "users#show", :as => :user
  resources :users
  root :to => 'title#welcome'
end
