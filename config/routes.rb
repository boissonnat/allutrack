Allutrack::Application.routes.draw do
  devise_for :users

  resources :projects
  resources :issues do
    get 'close', on: :member
    get 'reopen', on: :member
    resources :comments
  end
  resources :milestones

  match 'tagged' => 'issues#tagged', :as => 'tagged', via: [:get, :post]
  root 'index#index'

end
