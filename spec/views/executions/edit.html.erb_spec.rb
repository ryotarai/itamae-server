require 'rails_helper'

RSpec.describe "plans/edit", type: :view do
  before(:each) do
    @plan = assign(:plan, Plan.create!(
      :revision => nil,
      :status => 1,
      :is_dry_run => false
    ))
  end

  it "renders the edit plan form" do
    render

    assert_select "form[action=?][method=?]", plan_path(@plan), "post" do

      assert_select "input#plan_revision_id[name=?]", "plan[revision_id]"

      assert_select "input#plan_status[name=?]", "plan[status]"

      assert_select "input#plan_is_dry_run[name=?]", "plan[is_dry_run]"
    end
  end
end
