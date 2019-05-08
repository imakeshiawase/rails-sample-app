Rails.application.routes.draw do
  get 'track_images/index'
  get 'track_images/new'
  get 'track_images/edit'

  root "top#index"

  get "terms" => "top#terms", as: "terms"
  get "privacy" => "top#privacy", as: "privacy"
  get "company" => "top#company", as: "company"

  #エラー表示のテストのためのルーティング
  get "bad_request" => "top#bad_request"
  get "forbidden" => "top#forbidden"
  get "internal_server_error" => "top#internal_server_error"

  resources :users , only: [:index, :show] do
    get "search", on: :collection
    resources :tracks, only: [:index]
  end

  resource :session, only: [:new, :create, :destroy]
  resource :account, only: [:show, :edit, :update]
  resource :password, only: [:show, :edit, :update]

  resources :tracks do
    #memberは、特定のデータに対するアクションを、ルートに追加する際に利用する。
    patch :like, :unlike, on: :member
    #collectionは、全部のデータに対するアクションを、ルートに追加する際に利用する。
    get :clapped, on: :collection 
    resources :images, controller: "track_images"
  end

  namespace :admin do
    root "top#index"
    resources :users do
      get "search", on: :collection
    end
  end
end