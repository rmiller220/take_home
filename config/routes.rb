Rails.application.routes.draw do
  
  namespace :api do
    namespace :v0 do
      post '/subscribe', to: 'subscriptions#create'
      patch '/unsubscribe', to: 'customers#cancel'
      get '/subscriptions', to: 'customers#show'
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
