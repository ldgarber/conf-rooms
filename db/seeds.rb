# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#
small_room = Room.find_or_create_by(name: "Small Room")
small_room.update(capacity: "1-2 people")

couch_room = Room.find_or_create_by(name: "Couch Room")
couch_room.update(capacity: "2-4 people")

conference_room = Room.find_or_create_by(name: "Conference Room")
conference_room.update(capacity: "4-10 people")
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?