Rails.application.routes.draw do
  root "sessions#new"
  mount ActionCable.server => '/cable'

  get    "/login" => "sessions#new"
  post   "/login" => "sessions#create"
  delete "/logout" => "sessions#destroy"
  # post   '/users' => 'users#create'

  resources :locations, only: [:index]
  resources :subjects, only: %i[index show], constraints: { id: %r{[^/]+} }
  resources :messages
  resources :chat_rooms, only: [] do
    resources :messages, only: [:index], controller: "chat_rooms/messages"
  end

  namespace :schedules do
    put :update
  end

  resources :schedules, only: [] do
    get :subscription
    put :regenerate, on: :collection
    put :batch_update, on: :collection
  end

  namespace :student do
    get :dashboard
    get :subjects
    get :schedule
  end

  namespace :instructor do
    get :dashboard
    get :subjects
    get :preferences
    get :schedule
    put :update_preferences
  end

  namespace :coordinator do
    get :dashboard
    get :schedules
  end
end
