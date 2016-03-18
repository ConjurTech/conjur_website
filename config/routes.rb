Rails.application.routes.draw do
  post '/contact', to: 'welcome#contact'
  root 'welcome#index'
end
