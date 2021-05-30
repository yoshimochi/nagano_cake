Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :admins
  # , controllers: {
  #   sessions:       'admins/sessions',
  #   registrations:  'admins/registrations'
  # }
  # root 'homes#top'

  namespace :admin do
    get '/' => 'homes#top'
    resources :items, only: [:new, :create, :index, :show, :edit, :update]
  end
end
