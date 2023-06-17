# frozen_string_literal: true

class CreateCartItems < ActiveRecord::Migration[7.0]
  def change
    create_table :cart_items do |t|
      t.references :cart, null: false, foreign_key: true
      t.references :item, null: false, foreign_key: true
      t.integer :quantity, null: false, default: 1

      t.index %i[cart_id item_id], unique: true

      t.timestamps
    end
  end
end
