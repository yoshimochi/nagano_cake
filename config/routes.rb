Rails.application.routes.draw do

  devise_for :customers, module: "customers"

namespace :public do
  get 'customers/mypage' => 'customers#show'
  get 'customers/edit' => 'customers#edit'
  patch 'customers' => 'customers#update'
end

  devise_for :admins, path: 'admin',  module: "admins"

  namespace :admin do
    get '/' => 'homes#top'
    resources :items, only: [:new, :create, :index, :show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
  end

end
