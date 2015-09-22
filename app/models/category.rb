class Category < ActiveRecord::Base
  has_many :loans
  validates :name, presence: true, uniqueness: true
end
