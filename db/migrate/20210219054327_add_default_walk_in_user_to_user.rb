class AddDefaultWalkInUserToUser < ActiveRecord::Migration[6.1]
  def change
    user = User.new(
      name: "Walk-in",
      email: "--",
      password: "Null",
      user_type: "customer",
    )
    user.save
  end
end
