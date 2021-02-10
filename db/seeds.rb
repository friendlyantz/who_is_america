# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "destroying all entries"
Quote.where.not(parent_quote: nil).destroy_all
  puts "child quotes: PURGED"
  puts "...last quoteremaining: #{Quote.last.content}"

  Quote.destroy_all
  puts "all quotes purged"

Politician.destroy_all

User.destroy_all
  
Location.where(location_type: 1).destroy_all
  puts "states destroyed. yeeew!"

Location.destroy_all
  puts "destroying all entries: COMPLETE"
puts"---------------"

usa = Location.create(name: "USA", location_type: 0)
  puts "#{usa.name} created!"

puts "creating states..."
  states_array = [
    "ALABAMA	AL",
    "ALASKA	AK",
    "AMERICAN SAMOA	AS",
    "ARIZONA	AZ",
    "ARKANSAS	AR",
    "CALIFORNIA	CA",
    "COLORADO	CO",
    "CONNECTICUT	CT",
    "DELAWARE	DE",
    "DISTRICT OF COLUMBIA	DC",
    "FLORIDA	FL",
    "GEORGIA	GA",
    "GUAM	GU",
    "HAWAII	HI",
    "IDAHO	ID",
    "ILLINOIS	IL",
    "INDIANA	IN",
    "IOWA	IA",
    "KANSAS	KS",
    "KENTUCKY	KY",
    "LOUISIANA	LA",
    "MAINE	ME",
    "MARYLAND	MD",
    "MASSACHUSETTS	MA",
    "MICHIGAN	MI",
    "MINNESOTA	MN",
    "MISSISSIPPI	MS",
    "MISSOURI	MO",
    "MONTANA	MT",
    "NEBRASKA	NE",
    "NEVADA	NV",
    "NEW HAMPSHIRE	NH",
    "NEW JERSEY	NJ",
    "NEW MEXICO	NM",
    "NEW YORK	NY",
    "NORTH CAROLINA	NC",
    "NORTH DAKOTA	ND",
    "NORTHERN MARIANA IS,	MP",
    "OHIO	OH",
    "OKLAHOMA	OK",
    "OREGON	OR",
    "PENNSYLVANIA	PA",
    "PUERTO RICO	PR",
    "RHODE ISLAND	RI",
    "SOUTH CAROLINA	SC",
    "SOUTH DAKOTA	SD",
    "TENNESSEE	TN",
    "TEXAS	TX",
    "UTAH	UT",
    "VERMONT	VT",
    "VIRGINIA	VA",
    "VIRGIN ISLANDS	VI",
    "WASHINGTON	WA",
    "WEST VIRGINIA	WV",
    "WISCONSIN	WI",
    "WYOMING	WY" ] # watch out - whitespaces / tabs in the names!

states_array.each_with_index do | state, state_index |  
  recorded_state = Location.create(name: state, location_type: 1, parent_location: usa)
  puts "#{state_index} - #{recorded_state.name} created!"
end

puts"state generation: COMPLETE."
puts"---------------"


test_user = User.create(email: "test@test.com", password: "password")
  puts "test user created: login #{ User.first.email }, password: #{ User.first.password } "

puts"---------------"

trump = Politician.create(first_name: "Donald", last_name: "Trump", party: "Republicans", location: usa)
  puts "politician created: #{Politician.first.first_name} #{Politician.first.last_name}"

politicians_array = [
  "Joe Biden",
  "Hillary Clinton"
]
puts"---------------"

quote_trump = Quote.create(content: "YOLO-approved", source_link: "www.whitehouse.gov", politician: trump, creator: test_user)
  puts "quote created: #{ quote_trump.content }"

quote_trump2 = Quote.create(content: "YOLO2", source_link: "www.reddit.com", politician: trump, creator: test_user, parent_quote: quote_trump)
  puts "quote created: #{ quote_trump2.content }"

quote_trump3 = Quote.create(content: "YOLO3", source_link: "www.reddit.com", politician: trump, creator: test_user, parent_quote: quote_trump)
  puts "quote created: #{ quote_trump3.content }"

puts"---------------"
