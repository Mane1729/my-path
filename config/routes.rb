Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'pages#welcome'
  get '/page2', to: 'pages#page2'
  get '/result', to: 'users#result', as: 'result'
  get '/welcome', to: 'pages#welcome'


  post 'users/predict_career', to: 'users#predict_career'
end
