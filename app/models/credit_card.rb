class CreditCard < ApplicationRecord
  belongs_to :user
  # belongs_to :user, :optional => true
  validates :number, presence: true, length: { is: 16 }
  validates :cvv, presence: true, length: { is: 3 }
end
