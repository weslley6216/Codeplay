Rails.application.routes.draw do
  root 'home#index'
  devise_for :admins
  devise_for :users

  namespace :admin do
    resources :instructors
    resources :courses do
      resources :lessons
    end
  end
  
  resources :courses do
    resources :lessons

    post 'enroll', on: :member
    get 'my_enrolls', on: :collection
  end
  resources :instructors
end
