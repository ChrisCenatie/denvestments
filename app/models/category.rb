class Category < ActiveRecord::Base
  has_many :loans
end
