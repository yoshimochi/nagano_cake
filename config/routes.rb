Rails.application.routes.draw do
  devise_for :customers, module: "customers"
  # , controllers: {
  #   sessions:       'customers/sessions',
  #   passwords:      'customers/passwords',
  #   registrations:  'customers/registrations',
  # }
  namespace :admin do
    get 'genres/index'
    get 'genres/edit'
    resources :customers, only: [:index, :show, :edit, :update]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :admins, path: 'admin',  module: "admins"
  # , controllers: {
  #   sessions:       'admin/sessions'
  #   # passwords:      'admins/passwords',
  #   # registrations:  'admins/registrations',
  # }
  # root 'homes#top'

  namespace :admin do
    get '/' => 'homes#top'
    resources :items, only: [:new, :create, :index, :show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]

  end
end
