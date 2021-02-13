class AddColumnToMenus < ActiveRecord::Migration[6.1]
  def change
    add_column :menus, :menu_name, :string
  end
end
