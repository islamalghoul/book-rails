class Book < ApplicationRecord
  belongs_to :auther
  validates :name, presence: true, uniqueness: true
  validates :release_date, presence: true
  validate :release_date_not_in_future
  def self.filterrific_available_filters
    [:by_name, :by_auther_name, :search_query]
  end
  def self.filterrific_default_filter_params
    { by_name: nil, by_auther_name: nil, search_query: nil }
  end
  def self.to_csv
    attributes=%w{auther_name name release_date }
    CSV.generate(headers:true) do |csv|
      csv <<attributes
      all.each do |book|
        csv << [book.auther.name, book.name, book.release_date]
      end
    end
  end
  scope :by_name, ->(name) { where('books.name LIKE ?', "%#{name}%") if name.present? }
  scope :by_auther_name, ->(auther_name) { joins(:auther).where('authers.name LIKE ?', "%#{auther_name}%") if auther_name.present? }
  scope :search_query, lambda { |query|
  where("name LIKE :keyword OR release_date LIKE :keyword", keyword: "%#{query}%")
}

  private

  def release_date_not_in_future
    if release_date.present? && release_date > Date.current
      errors.add(:release_date, "can't be in the future")
    end
  end
end
