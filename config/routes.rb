Rails.application.routes.draw do

  # デバイス（Devise）に関連するルート
  devise_for :users

  # ルートパス（ホームページ）
  root 'rooms#index'


  get 'my_rooms', to: 'rooms#my_rooms'
  get 'rooms/search', to: 'rooms#search'
  

  # ログインせずにアクセス可能なページ
  resources :rooms, only: [:index, :show, :new] # GuestHouse一覧と詳細
  # resources :rooms
  # 検索結果ページなどの追加ルート（必要に応じて）
  


  # ログインが必要なページ
  authenticate :user do
    # 予約関連のルート
    resources :reservations, only: [:new, :create, :edit, :update, :index, :destroy]
    get 'reservations/confirm', to: 'reservations#confirm', as: 'reservations_confirm'
    get 'reservations/edit_confirm', to: 'reservations#edit_confirm', as: 'edit_confirm_reservations'

  end

    # ユーザー関連のルート（Devise以外）
    resources :users, only: [] do
      member do
        get 'show_account_info'
        get 'edit_account_info'
        patch 'update_account_info'
        get 'edit_profile'
        patch 'update_profile'
        get 'show_profile'
      end
    end

    # 自分のGuestHouseに関連するルート
    resources :rooms, except: [:index, :show, :new]
  
end