class User < ApplicationRecord
  has_secure_password

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
    User.find(user_id).cart
  end
end
