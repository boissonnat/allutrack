Allutrack::Application.routes.draw do
  #devise_for :users
  devise_for :users, :controllers => { :invitations => 'users/invitations' }

  resources :users
  resources :projects do
    get 'add_contributor', on: :member
    post 'add_contributor', on: :member
    get 'remove_contributor', on: :member
    post 'remove_contributor', on: :member
  end
  resources :issues do
    get 'close', on: :member
    get 'reopen', on: :member
    resources :comments
  end
  resources :milestones
  resources :labels

  root 'index#index'

end
