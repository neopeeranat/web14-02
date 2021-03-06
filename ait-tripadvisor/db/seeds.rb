# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user1 = User.find_or_create_by!(email: 'st116022@ait.ac.th') do |user|
  user.name = 'Peeranat Sangkatumvong'
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

user3 = User.find_or_create_by!(email: 'bajracharyayemini@gmail.com') do |user|
  user.name = 'yemini'
  user.password = '11111111'
  user.password_confirmation = '11111111'
  user.admin = true
end

user4 = User.find_or_create_by!(email: 'admin@ait-tripadvisor.com') do |user|
  user.name = 'Administrator'
  user.password = '11111111'
  user.password_confirmation = '11111111'
  user.admin = true
end

cat1 = Category.find_or_create_by!(name: 'School')
cat2 = Category.find_or_create_by!(name: 'Amusement Park')
cat3 = Category.find_or_create_by!(name: 'Shopping Mall')
cat4 = Category.find_or_create_by!(name: 'Temple')

taxi = Transportation.find_or_create_by!(type: 'Taxi')
bus = Transportation.find_or_create_by!(type: 'Bus')
bicycle = Transportation.find_or_create_by!(type: 'Bicycle')

place1 = Place.create_with(description:'Asian Institute of Technology', category: cat1, lat:14.0797792, lng:100.6114424).find_or_create_by!(name: 'AIT')
place2 = Place.create_with(description:'Amusement', category: cat2, lat:13.807484, lng:100.694918).find_or_create_by!(name: 'Siam Park')
place3 = Place.create_with(description:'Shopping mall', category: cat3, lat:13.98926, lng:100.617862).find_or_create_by!(name: 'Future Park')


direction = Direction.create_with(price: 543.21).find_or_create_by!(origin: place1, destination: place2, transportation: taxi, created_by: user1, description:"Go to left and then go to right and stop")
direction = Direction.create_with(price: 2345.55).find_or_create_by!(origin: place1, destination: place2, transportation: taxi, created_by: user2, description:"Go to right and then go to left and stop")
direction = Direction.create_with(price: 681).find_or_create_by!(origin: place1, destination: place2, transportation: taxi, created_by: user3, description:"Turn around and you will see your friend")
direction = Direction.create_with(price: 0).find_or_create_by!(origin: place1, destination: place3, transportation: bicycle, created_by: user1, description:"Turn around and you will see something scary...")
direction = Direction.create_with(price: 237.9).find_or_create_by!(origin: place1, destination: place3, transportation: taxi, created_by: user2, description:"Go straight and jump into pool")
direction = Direction.create_with(price: 777.77).find_or_create_by!(origin: place1, destination: place3, transportation: bus, created_by: user3, description:"You already there")
direction = Direction.create_with(price: 654.85).find_or_create_by!(origin: place1, destination: place3, transportation: taxi, created_by: user1, description:"Ask google map for more information")

direction = Direction.create_with(price: 237.9).find_or_create_by!(origin: place1, destination: place3, transportation: taxi, created_by: user4, description:"Go straight and jump into pool")
direction = Direction.create_with(price: 777.77).find_or_create_by!(origin: place1, destination: place3, transportation: bus, created_by: user4, description:"You already there")
direction = Direction.create_with(price: 654.85).find_or_create_by!(origin: place1, destination: place2, transportation: taxi, created_by: user4, description:"Ask google map for more information")
