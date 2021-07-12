class AddColumntimeforallocatedTableToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :time, :datetime
  end
end
