Rails.application.routes.draw do
  delete '/logout', to: 'sessions#destroy'
  post '/login', to: 'sessions#create'
  get '/login', to: 'sessions#new'
  get '/signup', to: 'users#new'
  get '/about', to: 'static_pages#about'
  get '/home', to: 'static_pages#home'
  get '/help', to: 'static_pages#help'
  get '/contact', to: 'static_pages#contact'
  root 'static_pages#home'
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
