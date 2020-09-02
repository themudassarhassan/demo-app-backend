class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.float :price
      t.belongs_to :user
      t.boolean :is_paid, default: true
      t.timestamps
    end
  end
end
