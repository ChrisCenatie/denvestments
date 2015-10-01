require "open-uri"

class Loan < ActiveRecord::Base
  validates :title, presence: true, uniqueness: true
  validates :description, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :category, presence: true

  belongs_to :category
  has_attached_file :avatar,
                    styles: { medium: "800x300#", thumb: "320x150#" },
                    default_url: "https://s3.amazonaws.com/turing-denvestments/assets/Richard_Stallman_by_Anders_Brenna_01.jpg"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
end
