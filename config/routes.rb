# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  get '/', to: 'portfolios#index'
  get '/portfolio', to: 'portfolios#index'
  get '/buy', to: 'portfolios#buy'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
