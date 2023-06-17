# frozen_string_literal: true

# == Schema Information
#
# Table name: bought_items
#
#  id         :integer          not null, primary key
#  quantity   :integer          default(1), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  cart_id    :integer          not null
#  item_id    :integer          not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_bought_items_on_cart_id  (cart_id)
#  index_bought_items_on_item_id  (item_id)
#  index_bought_items_on_user_id  (user_id)
#
# Foreign Keys
#
#  cart_id  (cart_id => carts.id)
#  item_id  (item_id => items.id)
#  user_id  (user_id => users.id)
#
class BoughtItem < ApplicationRecord
  belongs_to :user
  belongs_to :cart
  belongs_to :item
end
