# frozen_string_literal: true

Rails.application.routes.draw do
  root 'home#index'
  get 'depreciation/', to: 'depreciation#index', as: 'depreciation'
  get 'goods/:id/departments', to: 'goods#departments', as: 'good_departments', constraints: { format: :js }
  resources :departments
  resources :properties
  resources :good_categories
  resources :good_sub_kinds
  resources :good_kinds
  resources :goods do
    resources :movements, only: :create
    resources :financial_movements, only: :create
  end
end
