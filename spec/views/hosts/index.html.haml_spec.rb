require 'rails_helper'

RSpec.describe "hosts/index", type: :view do
  before(:each) do
    assign(:hosts, [
      Host.create!(
        :name => "Name"
      ),
      Host.create!(
        :name => "Name"
      )
    ])
  end

  it "renders a list of hosts" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
