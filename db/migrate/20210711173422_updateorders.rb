class Updateorders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :is_dine_in, :boolean
  end
end
