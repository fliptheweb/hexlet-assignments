# frozen_string_literal: true

Rails.application.routes.draw do
  root 'home#index'
  # BEGIN
  get 'posts/index'
  get 'posts/show'
  get 'posts/edit'

  resources :posts

  # END
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
