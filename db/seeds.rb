# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(
  name: "Admin",
  email: "admin@cafe.com",
  password: "123",
  user_type: "admin",
  cart: {},
)

User.create(
  name: "Clerk",
  email: "clerk@cafe.com",
  password: "123",
  user_type: "clerk",
  cart: {},
)

User.create(
  name: "User",
  email: "user@cafe.com",
  password: "123",
  user_type: "customer",
  cart: {},
)
