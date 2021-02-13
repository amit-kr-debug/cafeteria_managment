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

end
