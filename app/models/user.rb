class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :credit_cards
  has_many :orders
  has_many :addresses
  has_many :wish_list_items
  has_many :products, through: :wishlist_items
  accepts_nested_attributes_for :credit_cards
  validates :phone, presence: true, length: { is: 10 }

  def admin?
    self.role == "admin"
  end
end
