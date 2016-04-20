Rails.application.routes.draw do
  post '/contact', to: 'welcome#contact'
  get '/portfolio', to: 'welcome#portfolio'
  root 'welcome#index'
end
