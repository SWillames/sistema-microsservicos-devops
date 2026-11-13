class AddConstraintsToOrders < ActiveRecord::Migration[8.0]
  def up
    change_column_null :orders, :item_name, false
    change_column :orders, :total_amount, :decimal, precision: 12, scale: 2, null: false
    change_column_default :orders, :status, from: nil, to: "pending"
    change_column_null :orders, :status, false
    add_check_constraint :orders, "total_amount > 0", name: "orders_total_amount_positive"
  end

  def down
    remove_check_constraint :orders, name: "orders_total_amount_positive"
    change_column_null :orders, :status, true
    change_column_default :orders, :status, from: "pending", to: nil
    change_column :orders, :total_amount, :decimal, precision: nil, scale: nil, null: true
    change_column_null :orders, :item_name, true
  end
end
