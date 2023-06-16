class CreateBoughtItems < ActiveRecord::Migration[7.0]
  def change
    create_table :bought_items do |t|
      t.integer :item_id, null: false
      t.integer :quantity, null: false, default: 1

      t.timestamps
    end
  end
end
