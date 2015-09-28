class User < ActiveRecord::Base
  has_many :orders
  validates :username, presence: true, uniqueness: true
  validates :full_name, presence: true
  validates :address, presence: true
  has_secure_password
end
