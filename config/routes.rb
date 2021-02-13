Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "/" => "home#index"

  resources :users
  resources :admin do
    resources :editusers
  end
  resources :menus do
    resources :items
  end

  get "/signup" => "users#signup", as: :sign_up

  get "/signin" => "sessions#new", as: :new_session
  post "/signin" => "sessions#create", as: :session

  get "/dashboard" => "admin#dashboard", as: :dashboard

  get "/all_menus" => "admin#all_menus", as: :all_menus
  get "/edit_menus/#{:id}" => "admin#get_menu_items", as: :get_menu_items
end
