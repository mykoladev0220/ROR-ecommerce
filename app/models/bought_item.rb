# frozen_string_literal: true

class BoughtItem < ApplicationRecord
  belongs_to :user
  belongs_to :cart
  belongs_to :item
end
