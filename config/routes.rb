Rails.application.routes.draw do
  root 'home#index'
  devise_for :users

  namespace :admin do
    resources :courses do
      resources :lessons
    end
    resources :instructors
  end
  
  resources :courses do
    resources :lessons

    post 'enroll', on: :member
    get 'my_enrolls', on: :collection
  end
  resources :instructors
end
