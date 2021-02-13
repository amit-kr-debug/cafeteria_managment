class Menu < ApplicationRecord
  def self.of_menu(menu_id)
    all.where(menu_id: menu_id)
  end

  def self.categorized_menu
    menus_list = Menu.all
    grouped_menus = {}
    menus_list.map { |item| grouped_menus.has_key?(item.menu_id) ? grouped_menus[item.menu_id].push(item) : grouped_menus[item.menu_id] = [item] }
    return grouped_menus
  end


end
