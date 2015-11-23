Rails.application.routes.draw do
  get '/old', to: 'welcome#show'
  post '/contact', to: 'welcome#contact'
  root 'welcome#index'
end
