class Order < ActiveRecord::Base
  has_many :order_items
  belongs_to :user
  validates :status,
            presence: true,
            inclusion: { in: %w( Ordered Paid Cancelled Completed),
            message: "%{value} is not a valid status"}
end
