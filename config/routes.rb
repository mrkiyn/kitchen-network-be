Rails.application.routes.draw do
  get '/current_user', to: 'current_user#index'

  resources :job_listings do
    get 'applicants', on: :member
  end
  resources :applied_jobs, only: [:index, :create, :destroy]

  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  },
  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  get '*path', to: 'application#frontend_index', constraints: ->(request) do
    !request.xhr? && request.format.html?
  end
end
