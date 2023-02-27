Rails.application.routes.draw do
  root 'dashboard#main'

  resources :sessions, only: [:index, :show, :create, :destroy]
  resources :records, only: [:index, :new, :create, :destroy]

  get 'scrambles', to: 'scrambles#show'
end
