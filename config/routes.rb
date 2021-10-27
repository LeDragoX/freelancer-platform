Rails.application.routes.draw do
  devise_for :freelancers, path: 'freelancers'
  devise_for :users, path: 'users'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'home#index'

  resources :projects, only: %i[show new create edit update destroy] do
    get 'my_projects', on: :collection
    get 'my_proposals', on: :collection
    resources :proposals, only: %i[new create show edit update destroy]
  end
  resources :profiles, only: %i[show new create edit update] do
    get 'experiences', to: 'experiences#index', on: :collection
    resources :experiences, only: %i[show new create edit update destroy]
  end
end