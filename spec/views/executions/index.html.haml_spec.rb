require 'rails_helper'

RSpec.describe "executions/index", type: :view do
  before(:each) do
    assign(:executions, [
      Execution.create!(
        :revision => nil
      ),
      Execution.create!(
        :revision => nil
      )
    ])
  end

  it "renders a list of executions" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
