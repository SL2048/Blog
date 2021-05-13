Rails.application.routes.draw do
  resources :posts do
    resources :comments, except: [:show] do
      resources :reactions, only: [:create, :destroy]
    end
  end
  devise_for :users,
               path: '',
               path_names: {
                 sign_in: 'login',
                 sign_out: 'logout',
                 registration: 'signup'
               },
               controllers: {
                 sessions: 'auth/sessions',
                 registrations: 'auth/registrations'
               }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
