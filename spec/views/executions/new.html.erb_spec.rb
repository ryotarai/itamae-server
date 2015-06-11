require 'rails_helper'

RSpec.describe "plans/new", type: :view do
  before(:each) do
    assign(:plan, Plan.new(
      :revision => nil,
      :status => 1,
      :is_dry_run => false
    ))
  end

  it "renders new plan form" do
    render

    assert_select "form[action=?][method=?]", plans_path, "post" do

      assert_select "input#plan_revision_id[name=?]", "plan[revision_id]"

      assert_select "input#plan_status[name=?]", "plan[status]"

      assert_select "input#plan_is_dry_run[name=?]", "plan[is_dry_run]"
    end
  end
end
