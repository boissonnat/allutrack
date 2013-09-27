Allutrack::Application.routes.draw do
  devise_for :users

  resources :projects
  resources :issues
  root 'index#index'

end
