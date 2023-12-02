Rails.application.routes.draw do
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end

  if Rails.env.test?
    post 'test_setup_session', to: 'test#setup_session'
  end
  
  post "/graphql", to: "graphql#execute"
  
  root 'pages#welcome'
  
  get '/questions', to: 'pages#questions'
  get '/result', to: 'users#result', as: 'result'
  post 'users/predict_career', to: 'users#predict_career'
end
