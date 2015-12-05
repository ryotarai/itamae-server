require 'rails_helper'

RSpec.describe "Executions", type: :request do
  describe "GET /executions" do
    it "works! (now write some real specs)" do
      get executions_path
      expect(response).to have_http_status(200)
    end
  end
end
