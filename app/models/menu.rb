class Menu < ApplicationRecord
  has_many :items
  def self.active
    menu = all.where(active: true)
    menu[0]
  end

  def self.set_active(id)
     #removig current active menu
     menu = self.where(active: true)
     menu.each { |item|
       item.active = false
       item.save
     }
     #updating the active menu
     menu = self.find(id)
     menu.active = true
     menu.save
  end
end
