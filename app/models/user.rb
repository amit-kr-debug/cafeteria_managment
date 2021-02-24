class User < ApplicationRecord
  has_secure_password
  has_many :orders
  def self.admins
    all.where(user_type: "admin")
  end

  def self.clerks
    all.where(user_type: "clerk")
  end

  def self.customers
    all.where(user_type: "customer")
  end

  def self.details(user_id)
    User.find(user_id)
  end

  def self.cart(user_id)
    user = User.find(user_id)
    cart = user.cart
    cart.each do |item_id, quantity|
      if Menu.exists?(id: item_id) == false || Menu.find(item_id).active == false
        cart.delete(item_id)
      end
    end
    user.save
    user.cart
  end
end
