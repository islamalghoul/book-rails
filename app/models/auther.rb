class Auther < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  has_many :books
  validates :name, presence: true, uniqueness: true
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def self.filterrific_available_filters
  [:by_name]
end
def self.filterrific_default_filter_params
  { by_name: nil }
end
scope :by_name, ->(name) { where('authers.name LIKE ?', "%#{name}%") if name.present? }
end
