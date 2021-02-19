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

  def self.records(lower_date_limit, upper_date_limit)
    all.where("order_date >= ? and order_date <= ?", lower_date_limit, upper_date_limit)
  end
end
