Allutrack::Application.routes.draw do
  devise_for :users

  resources :projects

  root 'index#index'

end
