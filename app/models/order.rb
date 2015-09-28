class Order < ActiveRecord::Base
  has_many :order_items
  belongs_to :status
  belongs_to :user
end
