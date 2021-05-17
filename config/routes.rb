Rails.application.routes.draw do
  root 'home#index'
  resources :courses, only: %i[index show new create]
  resources :instructors
end
