Rails.application.routes.draw do
  get '/old', to: 'welcome#show'
  root 'welcome#index'
end
