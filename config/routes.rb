Rails.application.routes.draw do
  root 'home#index'
  devise_for :admins
  devise_for :users

  namespace :admin do
    resources :instructors
    resources :courses do
      resources :lessons, except: %i[index]
    end
  end

  namespace :user do
    resources :courses, only: %i[index show] do
      resources :lessons, only: %i[show]

      post 'enroll', on: :member
      get 'my_enrolls', on: :collection
    end
  end

  resources :courses, only: %i[show]

end
