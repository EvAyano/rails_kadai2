class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # ユーザーは複数の部屋を持つ
  has_many :rooms, dependent: :destroy
  # ユーザーは複数の予約を持つ
  has_many :reservations, dependent: :destroy

  # Active Storageを使用してユーザーのアイコン画像を添付
  has_one_attached :icon_image

  # ユーザー登録時に名前の存在を確認するバリデーション
  validates :email, presence: true

  # プロフィールを更新するためのメソッド（例）
  def update_profile(profile_params)
    self.update(profile_params)
  end
end
