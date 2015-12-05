require 'rails_helper'

RSpec.describe "Revisions", type: :request do
  describe "GET /revisions" do
    it "works! (now write some real specs)" do
      get revisions_path
      expect(response).to have_http_status(200)
    end
  end
end
