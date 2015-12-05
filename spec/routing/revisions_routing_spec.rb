require "rails_helper"

RSpec.describe RevisionsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/revisions").to route_to("revisions#index")
    end

    it "routes to #new" do
      expect(:get => "/revisions/new").to route_to("revisions#new")
    end

    it "routes to #show" do
      expect(:get => "/revisions/1").to route_to("revisions#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/revisions/1/edit").to route_to("revisions#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/revisions").to route_to("revisions#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/revisions/1").to route_to("revisions#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/revisions/1").to route_to("revisions#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/revisions/1").to route_to("revisions#destroy", :id => "1")
    end

  end
end
