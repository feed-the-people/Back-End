Rails.application.routes.draw do
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "graphql#execute"
  end  
  post "/graphql", to: "graphql#execute"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  post '/users/:id/upload_photo', to: 'users#upload_photo'
end
