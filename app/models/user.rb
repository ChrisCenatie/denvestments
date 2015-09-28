class User < ActiveRecord::Base
  validates :username, presence: true, uniqueness: true
  validates :full_name, presence: true
  validates :address, presence: true
  has_secure_password
end
