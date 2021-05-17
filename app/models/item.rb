class Item < ApplicationRecord
  belongs_to :menu
  def self.of_menu(menu_id)
    all.where(menu_id: menu_id)
  end

  def self.active_menu_items
    menu = Menu.active
    of_menu(menu.id)
  end
end
