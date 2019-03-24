# frozen_string_literal: true

require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  get 'goods/:id/departments', to: 'goods#departments', as: 'good_departments', constraints: { format: :js }
  resources :depreciations, except: %i[edit update destroy]
  resources :departments
  resources :properties
  resources :good_categories
  resources :good_sub_kinds
  resources :good_kinds
  resources :goods do
    resources :movements, only: :create
    resources :financial_movements, only: :create
  end
  mount Sidekiq::Web => '/sidekiq'
  resource :user, only: [:edit] do
    collection do
      patch :update_password
    end
  end
end
