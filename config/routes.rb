Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resource :slack_event, only: :create
  get 'team/connect', to: 'teams#connect'
  resources :favorites, only: [:create, :index]

  scope ':collection' do
    get 'articles/search(/:query)', to: 'articles#index', as: :articles
    post 'articles/search', to: 'articles#search'
    resources :tags, only: :index
  end

  match 'auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
  match 'auth/failure', to: redirect('/'), via: [:get, :post]
  match 'signout', to: 'sessions#destroy', as: 'signout', via: [:get, :post]

  root 'home#index'
end
