Rails.application.routes.draw do
  root 'home#index'
  
  devise_for :users
  
  resources :courses do
    resources :lessons

    post 'enroll', on: :member
    get 'my_enrolls', on: :collection
  end
  resources :instructors
end
