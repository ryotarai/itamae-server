require 'rails_helper'

RSpec.describe "host_executions/edit", type: :view do
  before(:each) do
    @host_execution = assign(:host_execution, HostExecution.create!(
      :host => nil,
      :execution => nil
    ))
  end

  it "renders the edit host_execution form" do
    render

    assert_select "form[action=?][method=?]", host_execution_path(@host_execution), "post" do

      assert_select "input#host_execution_host_id[name=?]", "host_execution[host_id]"

      assert_select "input#host_execution_execution_id[name=?]", "host_execution[execution_id]"
    end
  end
end
