require 'rails_helper'

RSpec.describe "host_executions/show", type: :view do
  before(:each) do
    @host_execution = assign(:host_execution, HostExecution.create!(
      :host => nil,
      :execution => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
