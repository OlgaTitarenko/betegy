Rails.application.routes.draw do

      get '/poker/assets/leaderboard', to: 'event#index'
      get '/poker/assets/leaderboard/:id', to: 'event#show'


  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
