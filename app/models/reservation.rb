class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :check_in_date, presence: true
  validates :check_out_date, presence: true
  validates :number_of_people, presence: true, numericality: { greater_than_or_equal_to: 1 }

  validate :check_in_date_cannot_be_in_the_past
  validate :check_out_date_must_be_after_check_in_date

  private

  def check_in_date_cannot_be_in_the_past
    errors.add(:check_in_date, "は本日以降の日付にしてね！！！") if check_in_date.present? && check_in_date < Date.today
  end

  def check_out_date_must_be_after_check_in_date
    if check_out_date.present? && check_in_date.present? && check_out_date <= check_in_date
      errors.add(:check_out_date, "はチェックイン日よりも後の日付にしてね！！！")
    end
  end
end
