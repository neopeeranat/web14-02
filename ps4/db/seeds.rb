# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

role = Role.find_or_create_by!(role_name:'Admin')
role2 = Role.find_or_create_by!(role_name:'User')
role3 = Role.find_or_create_by!(role_name:'Tester')

user = User.find_or_create_by!(email: 'admin@ait.ac.th') do |user|
  user.name = 'Peeranat'
  user.password = '11111111'
  user.password_confirmation = '11111111'
  user.phone_number = '12345678'
  user.role = role
end

user2 = User.find_or_create_by!(email: 'user@ait.ac.th') do |user|
  user.name = 'ABC'
  user.password = '11111111'
  user.password_confirmation = '11111111'
  user.role = role2
end

user2 = User.find_or_create_by!(email: 'ban@ait.ac.th') do |user|
  user.name = 'ABC'
  user.password = '11111111'
  user.password_confirmation = '11111111'
  user.role = role3
  user.banned = true
end
