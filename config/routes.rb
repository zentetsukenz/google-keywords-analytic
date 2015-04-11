Rails.application.routes.draw do
  
  # Keyword analyze
  get 'keyword_data_collect' => 'keyword_data_collect#index'
  post 'keyword_data_collect' => 'keyword_data_collect#upload'

  # Authentication
  get 'authentication' => 'authentication#index'
  get 'authentication/new' => 'authentication#new'
  post 'authentication' => 'authentication#signin'
  post 'authentication/register' => 'authentication#register'
  delete 'authentication' => 'authentication#signout'

  root 'dashboard#index'

end
