Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  authenticated :user do
    root 'main#home', as: :authenticated_root
  end

  devise_scope :user do
    root "devise/sessions#new"
  end

  resources :locations, only: [:index]
  resources :subjects, only: [:index]

  namespace :schedules do 
    get :show
  end
end
