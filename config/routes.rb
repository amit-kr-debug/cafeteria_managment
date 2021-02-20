Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "/" => "home#index"

  resources :users
  resources :editusers
  resources :menus do
    resources :items
  end

  resources :customers do
    resources :cart, :orders
  end

  get "/signup" => "users#signup", as: :sign_up

  get "/signin" => "sessions#new", as: :new_session
  post "/signin" => "sessions#create", as: :session
  delete "/signin" => "sessions#destroy", as: :destroy_session

  get "/dashboard" => "admin#dashboard", as: :dashboard

  get "/all_menus" => "admin#all_menus", as: :all_menus
  get "/edit_menus/#{:id}" => "admin#get_menu_items", as: :get_menu_items

  get "/pending_orders" => "admin#pending_orders", as: :pending_orders
  post "/pending_orders" => "admin#deliver_order", as: :deliver_order

  get "/records" => "admin#records_get", as: :get_records
  post "/records" => "admin#records_post", as: :display_records
  get "/records/invoice" => "admin#view_particular_order", as: :view_particular_order

  get "/clerks" => "clerks#index", as: :clerks_index
  get "/clerks/pending_orders" => "clerks#pending_orders", as: :clerks_pending_orders
  post "/clerks/pending_orders" => "clerks#deliver_order", as: :clerk_deliver_order
end
