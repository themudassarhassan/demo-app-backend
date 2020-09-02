class Product < ApplicationRecord
  include Rails.application.routes.url_helpers
  belongs_to :product_catagory
  has_many :comments

  belongs_to :user
  has_one_attached :image

  def get_image_url
    url_for(image) if image.attached?
  end
end
