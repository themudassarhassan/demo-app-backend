class AddResetColumnInUserTable < ActiveRecord::Migration[5.2]
  def change
    change_table :users do |t|
      t.integer :reset_token
    end
  end
end
