class CartItem < ApplicationRecord
  belongs_to :user
  belongs_to :item
  belongs_to :cart

  before_create :check_item_stock
  after_create :reduce_item_from_the_stock
  before_destroy :add_item_to_the_stock

  private

  def check_item_stock
    return unless quantity > item.quantity

    errors.add(:quantity, "is greater than item stock")
    throw(:abort)
  end

  def reduce_item_from_the_stock
    item.update(quantity: item.quantity - quantity)
  end

  def add_item_to_the_stock
    item.update(quantity: item.quantity + quantity)
  end
end
