class Room < ApplicationRecord
  belongs_to :user
  has_many :reservations, dependent: :destroy

  has_one_attached :image
  
  validates :name, :description, :price, :address, presence: true
  # 料金は1円以上でなければならない
  validates :price, numericality: { greater_than_or_equal_to: 1 }

  # Active Storageを使用、画像一つ追加
  has_one_attached :image

  # 施設作成日をyyyy/mm/ddの形式で表示する
  def formatted_creation_date
    created_at.strftime('%Y/%m/%d')
  end
end