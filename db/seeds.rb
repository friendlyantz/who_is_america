# ============== PURGING ENTRIES =============
  "==destroying all entries"

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
  
  SourceTracker.destroy_all
    puts "SourceTrackers purged" if SourceTracker.all.empty?

  User.destroy_all
    
  Location.where(location_type: 1).destroy_all
    puts "states destroyed. yeeew!"

  Location.destroy_all
    puts "locations purged"
    


  puts "destroying all entries: COMPLETE"
  puts '---------------------------'
# ============= PURGE ENDED. SEEDING STARTING==================
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
    puts '---------------------------'

# ========== USERS ===============
  test_user = User.create(email: "test@test.com", password: "password")
  puts "test user created: login #{ test_user.email }, password: #{ test_user.password } "
  # ========== ADMINS ===============
  admin_user = User.create(email: "admin@admin.com", password: "password", permissions: 2)
  puts "admin user created: login #{ admin_user.email }, password: #{ admin_user.password }, role: #{ admin_user.permissions } "

  puts '---------------------------'
  # =========================

# ============ SOURCE TRACKER =========
  puts '------SOURCE TRACKERS---------'
  
  source_trackers_hash = {
    'Google': 1,
    'Wikipedia': 0,
    'Daily Mail': 2,
    "Sun": 2,
    "New York Times": 1,
    "Time Magazine": 1,
    "Газета Труд": 2
  }
  
  source_trackers_hash.each_pair { |source, reliability| 
  print "Creasting #{source}: #{reliability}....."
  SourceTracker.create(name: source, reliability_by_admin: reliability)
  puts "#{SourceTracker.last.name} created! Relicability: #{SourceTracker.last.reliability_by_admin} "
  }

  puts '---------------------------'

  #   ==================================
  
# ========== POLITICIANS ===============
  puts '-------POLITICIANS---------'
  trump = Politician.create(first_name: "Donald", last_name: "Trump", party: "Republicans", location: usa)
  puts "politician created: #{Politician.first.first_name} #{Politician.first.last_name}"
  # ----- POLITICIAN::Democrats -------
  democrats_array = [
    "Joe Biden",
    "Hillary Clinton"
  ]

  democrats_array.each do |democrat|
    split_name = democrat.split
    Politician.create(first_name: split_name[0], last_name: split_name[1], party: "Democrats", location: usa)
    puts "politician created: #{Politician.last.first_name} #{Politician.last.last_name}"
    # --- quotes
    
  end
  puts '---------------------------'

# ========== QUOTES ===============
  quote_trump = Quote.create(content: "Make America great again!", source_link: "www.whitehouse.gov", politician: trump, creator: test_user)
  puts "quote created: #{ quote_trump.content }"

  quote_trump2 = Quote.create(content: "Nobody can build a wall like me.", source_link: "www.reddit.com", politician: trump, creator: test_user, parent_quote: quote_trump)
  puts "#{ Quote.last.politician.first_name }'s quote created: #{ Quote.last.content }"


  # ----  Quotes - SQL find by Politician name association
  # --Hillary - search by FIRST_name SQL
  Quote.create(content: "We are going to take things away from you on behalf of the common good.", source_link: "www.google.com", politician: Politician.find_by(first_name: "Hillary"), creator: test_user) #, parent_quote: quote_trump)
  puts "#{ Quote.last.politician.first_name }'s quote created: #{ Quote.last.content }"
  # --Biden - search by LAST_name SQL
  Quote.create(content: "I should not have been so cavalier.", source_link: "www.daily.com", politician: Politician.find_by(last_name: "Biden"), creator: test_user) #, parent_quote: quote_trump)
  puts "#{ Quote.last.politician.first_name }'s quote created: #{ Quote.last.content }"


  puts '---------------------------'

# ========== VOTING ===============
  puts '------VOTING---------'

  User.all.each do |voting_user|
    Quote.all.each do |voted_quote|
      vote = Vote.new(content: 1)
      vote.user = voting_user
      vote.quote = voted_quote
      if vote.save
        puts "#{Vote.last} created by #{Vote.last.user.email} for #{Vote.last.quote.content}"
      end
    end
  end

  puts '---------------------------'

# ========== USER TRACKER ===============
  puts '------USER_TRACKER---------'
  trkr = UserTracker.new(match_ratio: 0.2)
  trkr.user = User.first
  trkr.politician = Politician.first
  trkr.save
  puts "#{trkr} created!. ratio: #{trkr.match_ratio}"
  puts '---------------------------'
  # ============================
