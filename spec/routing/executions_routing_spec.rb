require "rails_helper"

RSpec.describe ExecutionsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/executions").to route_to("executions#index")
    end

    it "routes to #new" do
      expect(:get => "/executions/new").to route_to("executions#new")
    end

    it "routes to #show" do
      expect(:get => "/executions/1").to route_to("executions#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/executions/1/edit").to route_to("executions#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/executions").to route_to("executions#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/executions/1").to route_to("executions#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/executions/1").to route_to("executions#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/executions/1").to route_to("executions#destroy", :id => "1")
    end

  end
end
