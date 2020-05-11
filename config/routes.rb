Rails.application.routes.draw do
  resources :courses do
    resources :sections
  end

  scope 'user' do
    get 'edit_password', to: 'user#edit_password'
    patch 'edit_password', to: 'user#update_password'

    get 'edit_email', to: 'user#edit_email'
    patch 'edit_email', to: 'user#update_email'
  end
  #get 'user/edit_password'
  #patch 'user/edit_password', to: 'user#update_password'

  #get 'user/edit_email'
  #patch 'user/edit_email', to: 'user#update_email'

  resources :student_profiles
  resources :staff_profiles

  devise_for :users, controllers: {
      sessions: 'users/sessions'
  }

  root 'home#index'
end
