Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resource :message, only: :create
  resources :articles, only: :index

  root 'articles#index'
end
