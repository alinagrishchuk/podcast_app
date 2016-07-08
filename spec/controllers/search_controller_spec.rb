require 'rails_helper'

RSpec.describe SearchController, type: :controller do

  describe "GET #episodes" do
    it "returns http success" do
      get :episodes
      expect(response).to have_http_status(:success)
    end
  end

end
