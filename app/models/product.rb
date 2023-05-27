class Product < ApplicationRecord
  belongs_to :category
  has_one_attached :image
  default_scope { order(:name)}
end
