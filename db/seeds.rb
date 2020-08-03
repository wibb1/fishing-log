# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user1 = User.create(first_name: "Will", last_name: "Campbell", password: "apple", email: "wibb1@aol.com")
trip1 = Trip.create(name: "first trip", success: "good", species: "blues", body: "The blues were thick off the rock 100 yards from shore")
  # t.string :name, null: false
  # t.string :success, null: false
  # t.string :species, null: false
  # t.text :body
  # t.decimal :latitude
  # t.decimal :longitude
  # t.date :trip_date
  # t.time :trip_time