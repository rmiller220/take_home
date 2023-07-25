Rails.application.routes.draw do
  
  namespace :api do
    namespace :v0 do
      post '/subscribe', to: 'subscriptions#create'
      delete '/unsubscribe', to: 'subscriptions#destroy'
      get '/subscriptions', to: 'subscriptions#index'
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
