Rails.application.routes.draw do

  scope module: :public do
    root to: 'homes#top'
    get 'about' => 'homes#about'
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
      end
    end
    # post 'orders/comfirm' => 'orders#comfirm'
  end

  devise_for :customers, module: "customers"

  devise_for :admins, path: 'admin',  module: "admins"

  namespace :admin do
    get '/' => 'homes#top'
    resources :items, only: [:new, :create, :index, :show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
  end

end
