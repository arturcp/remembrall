Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resource :message, only: :create
  resources :articles, only: :index

  post 'articles/search', to: 'articles#search'
  get 'articles/search', to: redirect('/articles')

  root 'articles#index'
end
