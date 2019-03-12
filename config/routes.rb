Rails.application.routes.draw do
  resources :departments
  resources :properties
  resources :good_categories
  resources :good_sub_kinds
  resources :good_kinds
  resources :goods
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
