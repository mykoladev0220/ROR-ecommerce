# frozen_string_literal: true

# == Schema Information
#
# Table name: items
#
#  id          :integer          not null, primary key
#  code        :string           not null
#  description :string
#  name        :string           not null
#  price       :integer          not null
#  quantity    :integer          default(1), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Item < ApplicationRecord
  belongs_to :cart, optional: true
  belongs_to :cart_item, optional: true
  belongs_to :bought_item, optional: true

  validates :quantity, numericality: { greater_than_or_equal_to: 0 }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :name, presence: true, uniqueness: true
  validates :description, presence: true, length: { maximum: 1000 }

  after_update :broadcast_update

  def broadcast_update
    broadcast_replace_to 'items', target: id, partial: 'layouts/partials/item', locals: { item: self }
  end

  def self.total_stock_count
    Item.sum(:quantity)
  end
end
