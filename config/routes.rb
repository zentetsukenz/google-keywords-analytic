Rails.application.routes.draw do

  # Utility
  get 'utility' => 'utility#index'

  get 'utility/word-url-ads' => 'utility#word_url_ads'
  post 'utility/word-url-ads' => 'utility#word_url_ads_report'

  get 'utility/word-url' => 'utility#word_url'
  post 'utility/word-url' => 'utility#word_url_report'

  get 'utility/url-occurrence-ads' => 'utility#url_occurrence_ads'
  post 'utility/url-occurrence-ads' => 'utility#url_occurrence_ads_report'

  get 'utility/url-occurrence' => 'utility#url_occurrence'
  post 'utility/url-occurrence' => 'utility#url_occurrence_report'

  # Report
  get 'report' => 'report#index'
  get 'report/:id' => 'report#show'
  get 'report/view_html/:id' => 'report#show_html'
  delete 'report/:id' => 'report#delete'
  
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
