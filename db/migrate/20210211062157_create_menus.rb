class CreateMenus < ActiveRecord::Migration[6.1]
  def change
    create_table :menus do |t|
      t.integer :menu_id
      t.string :item_name
      t.string :description
      t.integer :price

      t.timestamps
    end
  end
end
