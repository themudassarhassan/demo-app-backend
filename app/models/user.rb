class User < ApplicationRecord
  rolify
  include Rails.application.routes.url_helpers
  has_secure_password

  has_one_attached :image
  has_many :comments
  has_many :products
  has_many :orders
  after_create :assign_default_role

  validates(:email, uniqueness: true)

  def get_image_url
    url_for(image) if image.attached?
  end

  private
  def assign_default_role
    add_role('customer') if roles.blank?
  end
end
