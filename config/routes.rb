Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resource :message, only: :create
  resource :favorite, only: :create

  post 'articles/search', to: 'articles#search'
  get 'articles/search/:query', to: 'articles#index', as: :articles

  match 'auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
  match 'auth/failure', to: redirect('/'), via: [:get, :post]
  match 'signout', to: 'sessions#destroy', as: 'signout', via: [:get, :post]

  root 'articles#index'
end
