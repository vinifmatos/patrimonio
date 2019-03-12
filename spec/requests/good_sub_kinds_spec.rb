require 'rails_helper'

RSpec.describe "GoodSubKinds", type: :request do
  describe "GET /good_sub_kinds" do
    it "works! (now write some real specs)" do
      get good_sub_kinds_path
      expect(response).to have_http_status(200)
    end
  end
end
