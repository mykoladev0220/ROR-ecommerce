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
require 'test_helper'

class ItemTest < ActiveSupport::TestCase
  test 'test total quantity of all items' do
    assert_equal 9, Item.total_stock_count
  end
end
