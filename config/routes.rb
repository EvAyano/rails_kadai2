Rails.application.routes.draw do
  # ルートパス（ホームページ）
  root 'rooms#index'

  # デバイス（Devise）に関連するルート
  devise_for :users

  # ログインせずにアクセス可能なページ
  resources :rooms, only: [:index, :show, :new] # GuestHouse一覧と詳細
  # 検索結果ページなどの追加ルート（必要に応じて）
  get 'rooms/search', to: 'rooms#search'
  
  # ログインが必要なページ
  authenticate :user do
    # 予約関連のルート
    resources :reservations, only: [:new, :create, :edit, :update, :index]

    # ユーザー関連のルート（Devise以外）
    get 'users/edit', to: 'users#edit'
    patch 'users', to: 'users#update'
    # 自分のGuestHouseに関連するルート
    get 'my_rooms', to: 'rooms#my_rooms'
    get 'rooms/new', to: 'rooms#new'
    post 'rooms', to: 'rooms#create'
    get 'rooms/:id/edit', to: 'rooms#edit', as: :edit_room
    patch 'rooms/:id', to: 'rooms#update'
    delete 'rooms/:id', to: 'rooms#destroy'
  end
end
