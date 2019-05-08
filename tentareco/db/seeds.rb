# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(
  name: "Tetsu",
  full_name: "豊島 哲也",
  email: "a@a.com",
  administrator: true,
  password: "tentareco!"
)

#「password_confirmation: "tentareco!"」は無くても動く