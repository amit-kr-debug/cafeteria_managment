class DropMenu < ActiveRecord::Migration[6.1]
  def change
    drop_table :table_orders
  end
end
