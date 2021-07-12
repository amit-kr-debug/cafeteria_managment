class AddColumnAllocatedTableToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :allocated_table, :integer
  end
end
