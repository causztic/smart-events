Rails.application.routes.draw do
  root "sessions#new"

  get    "/login" => "sessions#new"
  post   "/login" => "sessions#create"
  delete "/logout" => "sessions#destroy"
  # post   '/users' => 'users#create'

  resources :locations, only: [:index]
  resources :subjects, only: %i[index show], constraints: { id: %r{[^/]+} }

  namespace :schedules do
    get :show
  end

  namespace :student do
    get :dashboard
    get :subjects
  end

  namespace :instructor do
    get :dashboard
  end

  namespace :coordinator do
    get :dashboard
  end

  resources :locations, only: [:index]
  resources :subjects, only: [:index]

  namespace :schedules do 
    get :show
  end
end
