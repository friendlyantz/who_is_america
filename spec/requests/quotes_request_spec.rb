require 'rails_helper'

RSpec.describe "Quotes", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/quotes/index"
      expect(response).to have_http_status(:success)
    end
  end

end
