require 'rails_helper'

RSpec.describe "hosts/show", type: :view do
  before(:each) do
    @host = assign(:host, Host.create!(
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
  end
end
