require 'rails_helper'

RSpec.describe "HostExecutions", type: :request do
  describe "GET /host_executions" do
    it "works! (now write some real specs)" do
      get host_executions_path
      expect(response).to have_http_status(200)
    end
  end
end
