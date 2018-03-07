Rails.application.routes.draw do

  resources :locations, only: [:index]
  resources :subjects, only: [:index]

  namespace :schedules do 
    get :show
  end
end
