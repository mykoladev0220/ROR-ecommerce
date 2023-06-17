# frozen_string_literal: true

class CreateBoughtItems < ActiveRecord::Migration[7.0]
  def change
    create_table :bought_items do |t|
      t.references :cart, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.references :item, null: false, foreign_key: true
      t.integer :quantity, null: false, default: 1

      t.timestamps
    end
  end
end
