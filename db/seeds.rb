# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "destroying all entries"
Quote.destroy_all
Politician.destroy_all
User.destroy_all
Location.destroy_all
puts "destroying all entries: COMPLETE"
puts"---------------"

usa = Location.create(name: "USA", location_type: 0)
  puts "#{usa.name} created!"

puts"---------------"


test_user = User.create(email: "test@test.com", password: "password")
  puts "test user created: login #{ User.first.email }, password: #{ User.first.password } "

puts"---------------"

trump = Politician.create(first_name: "Donald", last_name: "Trump", party: "Republicans", location: usa)
  puts "politician created: #{Politician.first.first_name} #{Politician.first.last_name}"

puts"---------------"

quote_trump = Quote.create(content: "YOLO", source_link: "www.whitehouse.gov", politician: trump, creator: test_user)
  puts "quote created: #{ quote_trump.content }"

puts"---------------"