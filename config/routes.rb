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
    get :download
  end

  namespace :student do
    get :dashboard
    get :subjects
  end

  namespace :instructor do
    resource :chat_room, only: [] do
      get :start
    end

    get :dashboard
    get :subjects
    get :preferences
  end

  namespace :coordinator do
    get :dashboard
  end
end
