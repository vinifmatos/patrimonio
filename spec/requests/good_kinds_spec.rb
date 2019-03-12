require 'rails_helper'

RSpec.describe "GoodKinds", type: :request do
  describe "GET /good_kinds" do
    it "works! (now write some real specs)" do
      get good_kinds_path
      expect(response).to have_http_status(200)
    end
  end
end
