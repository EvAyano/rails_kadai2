class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :rooms, dependent: :destroy
  #
  has_many :reservations, dependent: :destroy

  has_one_attached :icon_image

  private

  def icon_image_type
    if icon_image.attached? && !icon_image.content_type.in?(%('image/jpeg image/png'))
      errors.add(:icon_image, 'はJPEGまたはPNG形式でなければなりません。')
    end
  end

  def icon_image_size
    if icon_image.attached? && icon_image.blob.byte_size > 5.megabytes
      errors.add(:icon_image, 'のサイズは5MB以下でなければなりません。')
    end
  end

  # ユーザー登録時に名前の存在を確認する
  validates :email, presence: true
  validates :name, presence: true
  
  validates :introduction, length: { maximum: 500 }


  # プロフィールを更新する
  def update_profile(profile_params)
    self.update(profile_params)
  end
end
