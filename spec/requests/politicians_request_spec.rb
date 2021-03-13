require 'rails_helper'
# require 'pry' 

RSpec.describe 'Politicians', type: :request do
  # current_user = User.first_or_create!(email: "rspecadmin@test.com", password: "password", password_confirmation: "password", permissions: 2)
  # current_user = User.find_by(permissions: 2)
  usa = Location.create(name: "USA", location_type: 0)
  @user = User.first_or_create!(email: "rspec2@test.com", password: "password", password_confirmation: "password", permissions: 0)
  puts @user.email

  let(:valid_attributes) do
    {
      # skip("Add a hash of attributes valid for your model")
      # 'id' => '1',
      'first_name' => 'RspecName',
      'last_name' => 'LastName',
      'party' => 'RSpecParty',
      # 'views' => '0'
    }
  end

  let(:invalid_attributes) do
    {
      # # skip("Add a hash of attributes invalid for your model")
      # 'id' => 'a',
      # 'title' => '1',
      # 'body' => '123'
      # 'views' => 'a'
      # TODO: do custom inavlid attr  #
    }
  end

  describe "GET /index" do
    it "returns http success" do

      get "/politicians"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      @politician = Politician.new(valid_attributes)
      @politician.location = usa
      @politician.save

      get politician_url(@politician)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "returns http success" do
      sign_in @user
      puts "permissions: " + current_user.permissions + " email: " + current_user.email
      get "/politicians/new"
      # expect(response).to have_http_status(:success)
      expect(response).to have_http_status(:success)
    end
  end
  # =========== P-UPD ======================

  # describe 'PATCH /update' do
  #   context 'with valid parameters' do
  #     let(:new_attributes) do
  #       skip('Add a hash of attributes valid for your model')
  #     end

  #     it 'updates the requested politician' do
  #       politician = Politician.new(valid_attributes)
  #       politician.user = current_user
  #       politician.save

  #       patch politician_url(politician), params: { politician: new_attributes }
  #       politician.reload
  #       skip('Add assertions for updated state')
  #     end

  #     it 'redirects to the politician' do
  #       politician = Politician.new(valid_attributes)
  #       politician.user = current_user
  #       politician.save
  #       patch politician_url(politician), params: { politician: new_attributes }
  #       politician.reload
  #       expect(response).to redirect_to(politician_url(politician))
  #     end
  #   end

    # context 'with invalid parameters' do
    #   it "renders a successful response (i.e. to display the 'edit' template)" do
    #     # politician = Politician.update(valid_attributes)
    #     # politician.user = current_user
    #     # politician.save

    #     patch politician_url(politician), params: { politician: invalid_attributes }
    #     expect(response).to be_successful
    #   end
    # end
  # end
end