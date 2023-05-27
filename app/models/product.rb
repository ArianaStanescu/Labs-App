class Product < ApplicationRecord
  belongs_to :category
  has_one_attached :image
  has_many :orders
  default_scope { order(:name)}
end
