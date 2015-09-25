require "open-uri"

class Loan < ActiveRecord::Base
  validates :title, presence: true
  validates :description, presence: true
  validates :price, presence: true

  belongs_to :category
  has_attached_file :avatar,
                    styles: { medium: "800x300#", thumb: "320x150#" },
                    default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  def avatar_remote_url(url)
    self.avatar = URI.parse(url)
    @avatar_remote_url
  end
end
