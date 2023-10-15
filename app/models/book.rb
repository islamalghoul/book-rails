class Book < ApplicationRecord
  belongs_to :auther
  validates :name, presence: true
  validates :release_date, presence: true
  validate :release_date_not_in_future

  private

  def release_date_not_in_future
    if release_date.present? && release_date > Date.current
      errors.add(:release_date, "can't be in the future")
    end
  end
end
