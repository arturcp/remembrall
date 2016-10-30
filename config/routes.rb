Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post 'articles/search', to: 'articles#search'
  get 'articles/:search_type/:query', to: 'articles#index', as: :articles

  root 'articles#index'
end
