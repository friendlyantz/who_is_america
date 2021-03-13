require 'rails_helper'
# require 'test_helper'
# require 'auth_helper'

# include AuthHelper
RSpec.describe "Quotes", type: :request do
  User.destroy_all
  user_test = User.create(email: "rspec2@test.com", password: "password", password_confirmation: "password", permissions: 0)
  user_creator = User.create(email: "creator@test.com", password: "password", password_confirmation: "password", permissions: 0)
  admin = User.create(id: 3, email: "admin@test.com", password: "password", password_confirmation: "password", permissions: 2)
  usa = Location.first_or_create(name: "USA", location_type: 0)
  trump = Politician.first_or_create(first_name: "Donald", last_name: "Trump", party: "Republicans", location: usa)
  
  let(:valid_attributes) do
    {
      'id' => '1',
      'content' => 'Test quote content',
      'source_link' => 'www.bing.com',
      'approval_status' => 0
      # 'politician' => Politician.last,
      # 'creator' => User.first
    }
  end

  let(:new_attributes) do
    {
      'id' => '1',
      'content' => 'EDITEDTest quote content',
      'source_link' => 'www.GOOGLE.com',
      'approval_status' => 0
      # 'politician' => Politician.last,
      # 'creator' => User.first
    }
  end

  let(:invalid_attributes) do
    {
      'id' => 'a',
      'content' => nil,
      # 'politician' => User.last,
      # 'creator' => Politician.first,
      'source_link' => 1
    }
  end

  describe "GET /index" do
    it "returns http success" do
      get "/quotes"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "renders new form for signed user" do
      sign_in user_test
      get "/quotes/new"
      expect(response).to render_template(:new)
    end
  end

  describe "GET /edit" do
    before(:example) do
      @quote = Quote.new(valid_attributes)
      @quote.creator = user_creator
      puts user_creator.email
      @quote.politician = Politician.last
      @quote.save
      # puts @quote.id
    end

    it "DOES NOT render edit form for the random user" do
      sign_in user_test
      get edit_quote_url(@quote)
      expect(response).to have_http_status(403)
    end
  end

  # describe "PATCH /update" do
  #   it "updates quote if modified by creator" do
  #     quote = Quote.new(valid_attributes)
  #     quote.creator = creator
  #     quote.politician = Politician.last
  #     quote.save
  #     sign_in creator
  #     # quote.update(valid_attributes)
  #     # redirect_to contribute_path

  #     patch quote_url(quote), params: { quote: new_attributes }
  #     quote.reload
  #     expect(response).to redirect_to(contribute_url)
  #   end
  # end

end
