# frozen_string_literal: true

# == Schema Information
#
# Table name: carts
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_carts_on_user_id  (user_id)
#
# Foreign Keys
#
#  user_id  (user_id => users.id)
#
class Cart < ApplicationRecord
  belongs_to :user, dependent: :destroy
  has_many :cart_items, dependent: :destroy

  validates :user, presence: true

  # TODO: Might use bulk insert here.
  def checkout
    CartItem.transaction do
      cart_items.each do |cart_item|
        BoughtItem.create!(item: cart_item.item, quantity: cart_item.quantity, user:, cart: self)
      end

      # We want to destroy all cart items without adding them back to the stock.
      cart_items.destroy_all
    end
  end

  def total
    cart_items.includes(:item).map { |cart_item| calculate_item_total(cart_item) }.sum
  end

  private

  def calculate_item_total(cart_item)
    cart_item.quantity * cart_item.item.price
  end
end
