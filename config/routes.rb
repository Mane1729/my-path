Rails.application.routes.draw do
  root 'pages#welcome'
  
  get '/questions', to: 'pages#questions'
  get '/result', to: 'users#result', as: 'result'
  post 'users/predict_career', to: 'users#predict_career'
end
