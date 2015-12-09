require 'rails_helper'

RSpec.describe "host_executions/new", type: :view do
  before(:each) do
    assign(:host_execution, HostExecution.new(
      :host => nil,
      :execution => nil
    ))
  end

  it "renders new host_execution form" do
    render

    assert_select "form[action=?][method=?]", host_executions_path, "post" do

      assert_select "input#host_execution_host_id[name=?]", "host_execution[host_id]"

      assert_select "input#host_execution_execution_id[name=?]", "host_execution[execution_id]"
    end
  end
end
