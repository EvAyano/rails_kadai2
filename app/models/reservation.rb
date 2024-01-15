class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :check_in_date, presence: true
  validates :check_out_date, presence: true
  validates :number_of_people, presence: true, numericality: { greater_than_or_equal_to: 1 }

  # チェックイン日は本日以降であることを確認するカスタム
  validate :check_in_date_cannot_be_in_the_past

  # チェックアウト日はチェックイン日より後であることを確認する
  validate :check_out_date_must_be_after_check_in_date

  private

  def check_in_date_cannot_be_in_the_past
    return if check_in_date.blank?

    if check_in_date < Date.today
      errors.add(:check_in_date, "は本日以降の日付でなければなりません")
    end
  end

  def check_out_date_must_be_after_check_in_date
    return if check_out_date.blank? || check_in_date.blank? 

    if check_out_date <= check_in_date
      errors.add(:check_out_date, "はチェックイン日よりも後の日付でなければなりません")
    end
  end


end
