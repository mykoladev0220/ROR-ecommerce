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
  validates :cart_items, presence: true, optional: true

  def total
    cart_items.sum(:price)
  end
end
