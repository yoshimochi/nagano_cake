Rails.application.routes.draw do
  root to: 'homes#top'
  get 'about' => 'homes#about'

  devise_for :admins, path: 'admins', controllers: {
    sessions: 'admins/sessions',
    passwords: 'adminds/passwords',
    registrations: 'admins/registrations'
  }

  devise_for :customers, path: 'customers'
  # , path: 'customers', controllers: {
  #   sessions: 'customers/sessions',
  #   passwords: 'customers/passwords',
  #   registrations: 'customers/registrations'
  # }


  scope module: :public do
    get 'customers/mypage' => 'customers#show'
    get 'customers/edit' => 'customers#edit'
    patch 'customers' => 'customers#update'
    resources :items, only:[:index, :show]
    resources :cart_items, only:[:index, :update, :destroy, :create] do
      collection do
        delete 'destroy_all'
      end
    end
    resources :orders, only:[:new, :create, :index, :show] do
      collection do
        post 'confirm'
        get 'thanks'
      end
    end
    resources :addresses, only:[:index, :edit, :create, :update, :destroy]
  end



  namespace :admin do
    get '/' => 'homes#top'
    resources :items, only: [:new, :create, :index, :show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
  end

end
