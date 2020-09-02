class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.string :comment
      t.belongs_to :product
      t.string :feedback
      t.belongs_to :user
      t.timestamps
    end
  end
end
