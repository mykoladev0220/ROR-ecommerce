class Cart < ApplicationRecord
  belongs_to :user
  has_many :items, through: :user, source: :cart_items
end
