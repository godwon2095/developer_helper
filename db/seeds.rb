# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?
City.find_or_create_by(city_name: "California")
City.find_or_create_by(city_name: "Texas")
City.find_or_create_by(city_name: "Assam")
State.find_or_create_by(city: City.first, state_name: "Lon Angeles")
State.find_or_create_by(city: City.first, state_name: "San Diego")
State.find_or_create_by(city: City.second, state_name: "Dallas")
State.find_or_create_by(city: City.second, state_name: "Austin")
State.find_or_create_by(city: City.third, state_name: "Dispur")
State.find_or_create_by(city: City.third, state_name: "Guwahati")
