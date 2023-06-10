class Product < ApplicationRecord
  belongs_to :category
  has_one_attached :image
  has_many :orders
  has_many :wish_list_items
  has_many :users, through: :wishlist_items
  
end
