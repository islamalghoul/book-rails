Rails.application.routes.draw do
  devise_for :authers
  root 'home#index'
  resources :books
  

  resources :authors

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
