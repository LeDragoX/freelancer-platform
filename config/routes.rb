Rails.application.routes.draw do
  devise_for :freelancers, path: 'freelancers'
  devise_for :users, path: 'users'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'home#index'

  resources :projects, only: %i[show new create edit update] do
      get 'my_projects', on: :collection
  end
end