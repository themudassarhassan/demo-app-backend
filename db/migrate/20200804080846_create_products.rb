class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name
      t.float :price
      t.integer :quantity
      t.belongs_to :product_catagory
      t.belongs_to :user
      t.timestamps
    end
  end
end
