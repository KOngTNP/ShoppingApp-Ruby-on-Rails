class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.string :image, null: true
      t.decimal :price, precision: 8, scale: 2, null: false

      t.timestamps
    end
  end
end
