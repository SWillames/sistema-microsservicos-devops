class CreateOrders < ActiveRecord::Migration[8.0]
  def change
    create_table :orders do |t|
      t.string :item_name
      t.decimal :total_amount
      t.string :status

      t.timestamps
    end
  end
end
