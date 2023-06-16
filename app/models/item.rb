class Item < ApplicationRecord
  belongs_to :cart, optional: true
  belongs_to :bought_item, optional: true
  belongs_to :cart_item, optional: true
end
