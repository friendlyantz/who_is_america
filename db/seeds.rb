puts "==destroying all entries"

puts "destroying UserTrackers"
UserTracker.destroy_all

puts "destroying VOTES"
Vote.destroy_all

puts "#{Quote.where.not(parent_quote: nil)}"

Quote.where.not(parent_quote: nil).destroy_all
  puts "child quotes: PURGED"

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
puts '------VOTING---------'

vote = Vote.new(content: 1)
vote.user = User.first
vote.quote = Quote.first
vote.save

puts "#{vote} created!"
puts '---------------'

puts '------USER_TRACKER---------'
trkr = UserTracker.new(match_ratio: 0.2)
trkr.user = User.first
trkr.politician = Politician.first
trkr.save
puts "#{trkr} created!. ratio: #{trkr.match_ratio}"
puts '---------------'
