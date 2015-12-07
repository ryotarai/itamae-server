require 'rails_helper'

RSpec.describe "host_executions/index", type: :view do
  before(:each) do
    assign(:host_executions, [
      HostExecution.create!(
        :host => nil,
        :execution => nil
      ),
      HostExecution.create!(
        :host => nil,
        :execution => nil
      )
    ])
  end

  it "renders a list of host_executions" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
