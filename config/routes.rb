Rails.application.routes.draw do
  root 'home#index'
  devise_for :admins
  devise_for :users
  resources :courses, only: %i[show]

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

  
  namespace :api do
    namespace :v1 do
      resources :courses, only: %i[index]
    end
  end
end
