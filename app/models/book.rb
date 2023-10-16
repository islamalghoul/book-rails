class Book < ApplicationRecord
  belongs_to :auther 
  validates :name, presence: true, uniqueness: true
  validates :release_date, presence: true
  validate :release_date_not_in_future

  def self.options_for_sorted_by
    [
      ['Book Name (A-Z)', 'name_asc'],
      ['Book Name (Z-A)', 'name_desc'],
      ['Author Name (A-Z)', 'auther_name_asc'],  
      ['Author Name (Z-A)', 'auther_name_desc'],  
      ['Release Date (Oldest first)', 'release_date_asc'],
      ['Release Date (Newest first)', 'release_date_desc']
    ]
  end

  def self.filterrific_available_filters
    [:by_name, :by_auther_name, :by_release_date] 
  end
  def self.filterrific_default_filter_params
    { by_name: nil, by_auther_name: nil, by_release_date: nil }
  end
  scope :by_name, ->(name) { where('books.name LIKE ?', "%#{name}%") if name.present? }
  scope :by_auther_name, ->(auther_name) { joins(:auther).where('authers.name LIKE ?', "%#{auther_name}%") if auther_name.present? }  
  scope :by_release_date, ->(date) { where(release_date: date) if date.present? }
  private

  def release_date_not_in_future
    if release_date.present? && release_date > Date.current
      errors.add(:release_date, "can't be in the future")
    end
  end
end
