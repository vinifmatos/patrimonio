# frozen_string_literal: true

Rails.application.routes.draw do
  root 'home#index'
  resources :departments
  resources :properties
  resources :good_categories
  resources :good_sub_kinds
  resources :good_kinds
  resources :goods do
    resources :movements, only: :create
  end
end
