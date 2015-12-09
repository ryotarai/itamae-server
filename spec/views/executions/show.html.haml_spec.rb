require 'rails_helper'

RSpec.describe "executions/show", type: :view do
  before(:each) do
    @execution = assign(:execution, Execution.create!(
      :revision => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
  end
end
