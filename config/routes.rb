Rails.application.routes.draw do
  root 'home#index'

  get "/get_states_by_city/:city_id" => "citys#get_states_by_city"

  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
