# frozen_string_literal: true

class Item < ApplicationRecord
  belongs_to :cart, optional: true
  belongs_to :cart_item, optional: true
  belongs_to :bought_item, optional: true

  validates :quantity, numericality: { greater_than_or_equal_to: 0 }
end
