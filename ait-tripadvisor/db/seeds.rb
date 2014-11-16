# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user1 = User.find_or_create_by!(email: 'st116022@ait.ac.th') do |user|
  user.name = 'Siraj'
  user.password = '11111111'
  user.password_confirmation = '11111111'
  user.admin = true
end

user2 = User.find_or_create_by!(email: 'msiraj83@gmail.com') do |user|
  user.name = 'siraj'
  user.password = '11111111'
  user.password_confirmation = '11111111'
  user.admin = true
end

trans = Transportation.find_or_create_by!(type: 'Taxi')
Transportation.find_or_create_by!(type: 'Bus')
Transportation.find_or_create_by!(type: 'Bicycle')

place1 = Place.find_or_create_by!(name: 'AIT') do |place|
  place.description = 'Asian Institute of Technology'
end

place2 = Place.find_or_create_by!(name: 'Siam Park') do |place|
  place.description = 'Amusement'
end

direction = Direction.find_or_create_by!(origin: place1, destination: place2, transportation: trans, created_by: user1) do |direction|
  direction.price = 543.21
end
