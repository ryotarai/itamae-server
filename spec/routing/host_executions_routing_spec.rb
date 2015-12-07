require "rails_helper"

RSpec.describe HostExecutionsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/host_executions").to route_to("host_executions#index")
    end

    it "routes to #new" do
      expect(:get => "/host_executions/new").to route_to("host_executions#new")
    end

    it "routes to #show" do
      expect(:get => "/host_executions/1").to route_to("host_executions#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/host_executions/1/edit").to route_to("host_executions#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/host_executions").to route_to("host_executions#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/host_executions/1").to route_to("host_executions#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/host_executions/1").to route_to("host_executions#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/host_executions/1").to route_to("host_executions#destroy", :id => "1")
    end

  end
end
