require 'rails_helper'

RSpec.describe Quote, type: :model do
  puts "==> creating user, politian and source tracker for quote testing..."
    user = User.new(
      email: "rspec@test.com", 
      password: "password", 
      password_confirmation: "password"
    )
    vlad = Politician.new(
      first_name: "Vlad", 
      last_name: "Put", 
      party: "ZOG"
    )
    source_tracker = SourceTracker.new(name: "www.murica.gov")
    # ================== TESTING ======================
  it "has content" do

    quote = Quote.new(
      source_link: "www.murica.gov/somebsquote1.html",
      creator: user,
      politician: vlad,
      source_tracker: source_tracker
    )
    
    expect(quote).to_not be_valid
    
    quote.content = "Yoloooooo!"  
    expect(quote).to be_valid  
  end
  
  it "has quote content length to be: 10 < ... < 100" do
    quote = Quote.new(
      source_link: "www.murica.gov/somebsquote1.html",
      creator: user,
      politician: vlad,
      source_tracker: source_tracker
    )
    
    
    quote.content = 'Cupidatat do in minim Lorem culpa magna commodo velit veniam proident exercitation ad. Culpa veniam occaecat deserunt dolore aute minim magna aliquip est laboris et veniam tempor eu. Sit pariatur minim nostrud minim mollit.'
    expect(quote).to_not be_valid
    
    quote.content = "0"
    expect(quote).to_not be_valid
    
    hundred_string = 'Cupidatat do in minim Lorem culpa magna commodo velit veniam proident exercitation ad. Culpa veniam1'
    quote.content = hundred_string
    expect(quote).to be_valid
    
  end
  
  
  it "has source link" do
    
  end
  
  it "has valid source link" do
    # TODO: Regex validation
  end
  
  it "has approval status" do
  end
  
  it "has politician" do
  end
  
  it "has creator" do
  end

  it "does not have grand-parent" do
    # TODO: 
  end
  
end
