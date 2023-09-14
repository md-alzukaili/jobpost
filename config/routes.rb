Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'

  mount_devise_token_auth_for 'Admin', at: 'admin_auth'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html


  get '/posts' => 'posts#index'
  get '/posts/new' => 'posts#new'
  get '/posts/:id' => 'posts#show'
  post '/posts' => 'posts#create'
  get '/posts/:id/edit' => 'posts#edit'
  patch '/posts/:id' => 'posts#update'
  put '/posts/:id' => 'posts#update'
  delete '/posts/:id' => 'posts#destroy'

  get '/applicants' => 'applicants#index'
  get '/applicants/new' => 'applicants#new'
  get '/applicants/:id' => 'applicants#show'
  post '/applicants' => 'applicants#create'
  get '/applicants/:id/edit' => 'applicants#edit'
  patch '/applicants/:id' => 'applicants#update'
  put '/applicants/:id' => 'applicants#update'
  delete '/applicants/:id' => 'applicants#destroy'
  put '/applicants/:id/seen' => 'applicants#seen'

  # Defines the root path route ("/")
  # root "articles#index"
end
