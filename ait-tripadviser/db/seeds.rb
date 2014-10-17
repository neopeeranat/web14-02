# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user1 = User.find_or_create_by!(email: 'st116022@ait.ac.th') do |user|
  user.name = 'Peeranat'
  user.password = '11111111'
  user.password_confirmation = '11111111'
end

trans = Transportation.find_or_create_by!(type: 'Taxi')
Transportation.find_or_create_by!(type: 'Bus')

place1 = Place.find_or_create_by!(name: 'AIT') do |place|
  place.description = 'Asian Institute of Technology'
end

place2 = Place.find_or_create_by!(name: 'Siam Park') do |place|
  place.description = 'Amusement'
end

direction = Direction.find_or_create_by!(id: 1) do |direction|
  direction.origin = place1
  direction.destination = place2
  direction.transportation = trans
  direction.created_by = user1
  direction.price = 543.21
end
