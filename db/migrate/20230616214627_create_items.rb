class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.integer :price, null: false
      t.integer :quantity, null: false, default: 1
      t.string :code, null: false
      t.string :description

      t.timestamps
    end
  end
end
