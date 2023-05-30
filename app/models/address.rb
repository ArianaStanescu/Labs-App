class Address < ApplicationRecord
  enum address_type: { delivery: 0, billing: 1, both: 2 }

  belongs_to :user
end
