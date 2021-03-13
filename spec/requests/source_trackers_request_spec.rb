require 'rails_helper'

RSpec.describe "SourceTrackers", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/source_trackers/index"
      expect(response).to have_http_status(:success)
    end
  end

end
