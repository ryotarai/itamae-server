require 'rails_helper'

RSpec.describe "plans/show", type: :view do
  before(:each) do
    @plan = assign(:plan, Plan.create!(
      :revision => nil,
      :status => 1,
      :is_dry_run => false
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/false/)
  end
end
