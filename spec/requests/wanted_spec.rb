require 'rails_helper'

RSpec.describe "Wanteds", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/wanted/index"
      expect(response).to have_http_status(:success)
    end
  end

end
