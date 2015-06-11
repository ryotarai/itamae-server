require "rails_helper"

RSpec.describe PlansController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/plans").to route_to("plans#index")
    end

    it "routes to #new" do
      expect(:get => "/plans/new").to route_to("plans#new")
    end

    it "routes to #show" do
      expect(:get => "/plans/1").to route_to("plans#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/plans/1/edit").to route_to("plans#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/plans").to route_to("plans#create")
    end

    it "routes to #update" do
      expect(:put => "/plans/1").to route_to("plans#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/plans/1").to route_to("plans#destroy", :id => "1")
    end

  end
end
