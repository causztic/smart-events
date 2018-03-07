Rails.application.routes.draw do
  root to: "main#home"
  
  get    '/login' => 'sessions#new'
  post   '/login' => 'sessions#create'
  delete '/logout'=> 'sessions#destroy'
  #post   '/users' => 'users#create'

  resources :locations, only: [:index]
  resources :subjects, only: [:index]

  namespace :schedules do 
    get :show
  end
end
