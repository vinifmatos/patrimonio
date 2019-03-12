require 'rails_helper'

RSpec.describe "GoodCategories", type: :request do
  describe "GET /good_categories" do
    it "works! (now write some real specs)" do
      get good_categories_path
      expect(response).to have_http_status(200)
    end
  end
end
