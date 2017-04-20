Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: :sessions, registrations: 'api/v1/users' }

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      get '/status', to: 'status#all'
      get '/status/protected', to: 'status#protected'
      post '/users', to: 'users#create'
      get '/code_schools', to: 'code_schools#index'
    end
  end

  # TODO Remove in production
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
end
