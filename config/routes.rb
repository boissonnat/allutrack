Allutrack::Application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  #ActiveAdmin.routes(self)
  #devise_for :users
  #ActiveAdmin.routes(self)
  devise_for :users, :controllers => { :invitations => 'users/invitations' }
  ActiveAdmin.routes(self)

  resources :users
  resources :projects do
    get 'add_contributor', on: :member
    post 'add_contributor', on: :member
    get 'remove_contributor', on: :member
    post 'remove_contributor', on: :member
    get 'resend_invitation_contributor', on: :member
    post 'resend_invitation_contributor', on: :member
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
