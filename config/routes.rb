Allutrack::Application.routes.draw do
  devise_for :users

  resources :projects
  resources :issues do
    resources :comments
  end
  root 'index#index'

end
