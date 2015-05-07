require 'rails_helper'

RSpec.describe "plans/index", type: :view do
  before(:each) do
    assign(:plans, [
      Plan.create!(
        :revision => nil,
        :status => 1,
        :is_dry_run => false
      ),
      Plan.create!(
        :revision => nil,
        :status => 1,
        :is_dry_run => false
      )
    ])
  end

  it "renders a list of plans" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
