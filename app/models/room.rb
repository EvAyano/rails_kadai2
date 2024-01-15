class Room < ApplicationRecord
  # 各部屋は一人のユーザーに属しています
  belongs_to :user
  # 一つの部屋は多数の予約を持っています
  has_many :reservations, dependent: :destroy

  # 必須項目として名前、詳細、料金、住所の存在を確認
  validates :name, :description, :price, :address, presence: true
  # 料金は1円以上でなければならない
  validates :price, numericality: { greater_than_or_equal_to: 1 }

  # Active Storageを使用して一つの画像を添付
  has_one_attached :image

  # 施設作成日をyyyy/mm/ddの形式で表示するメソッド
  def formatted_creation_date
    created_at.strftime('%Y/%m/%d')
  end
end