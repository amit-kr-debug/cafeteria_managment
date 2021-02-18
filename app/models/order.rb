class Order < ApplicationRecord
  belongs_to :user

  def self.of_user(user)
    all.where(user_id: user.id)
  end

  def self.pending
    all.where("delivered = ?", false)
  end

  def self.delivered
    all.where("delivered = ?", true)
  end
end
