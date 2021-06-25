Rails.application.routes.draw do

  devise_for :admins, path: 'admins', controllers: {
    sessions: 'admins/sessions',
    passwords: 'adminds/passwords',
    registrations: 'admins/registrations'
  }

  devise_for :customers


  scope module: :public do
    root to: 'homes#top'
    get 'about' => 'homes#about'

    get 'customers/mypage' => 'customers#show'
    get 'customers/unsubscribe' => 'customers#unsubscribe'
    patch 'customers/widthdraw' => 'customers#widthdraw', as: "customers_widthdraw"
    resources :customers, only:[:edit, :update]

    resources :items, only:[:index, :show]

    resources :cart_items, only:[:index, :update, :destroy, :create] do
      collection do
        delete 'destroy_all'
      end
    end

    resources :orders, only:[:new, :create, :index, :show, :destroy] do
      collection do
        post 'confirm'
        get 'thanks'
      end
    end

    resources :addresses, only:[:index, :edit, :create, :update, :destroy]
  end



  namespace :admin do
    root to: 'homes#top'

    resources :items, only: [:new, :create, :index, :show, :edit, :update] do
      collection do
        get 'search'
      end
    end
    resources :genres, only: [:index, :create, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:show, :update]
    resources :order_products, only: [:update]

  end

end
