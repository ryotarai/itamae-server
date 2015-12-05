require 'rails_helper'

RSpec.describe "revisions/show", type: :view do
  before(:each) do
    @revision = assign(:revision, Revision.create!(
      :name => "Name",
      :url => "Url"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Url/)
  end
end
