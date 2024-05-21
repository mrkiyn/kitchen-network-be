Rails.application.routes.draw do
  get '/current_user', to: 'current_user#index'
  
  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  },
  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  namespace :admin do
    resources :users, only: [:index, :edit, :update] do
      collection do
        get 'pending', to: 'users#pending_users'
      end
    end
  end
end
