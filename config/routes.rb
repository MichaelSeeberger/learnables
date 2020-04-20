Rails.application.routes.draw do
  resources :student_profiles
  resources :staff_profiles

  devise_for :users, controllers: {
      sessions: 'users/sessions'
  }

  root 'home#index'
end
