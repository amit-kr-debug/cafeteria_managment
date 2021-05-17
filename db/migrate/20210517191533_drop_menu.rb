class DropMenu < ActiveRecord::Migration[6.1]
  def change
    drop_table :menus
  end
end
