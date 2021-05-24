class Product < ApplicationRecord

  enum status: { draft: 0, published: 1, archieved: 2 }
  mount_uploader :image, ImageUploader

  has_many :product_categories, dependent: :destroy
  has_many :categories, through: :product_categories

  has_many :orders
  has_many :users, through: :orders

end
