require 'rails_helper'

RSpec.describe "revisions/index", type: :view do
  before(:each) do
    assign(:revisions, [
      Revision.create!(
        :name => "Name",
        :tar_url => "Tar Url"
      ),
      Revision.create!(
        :name => "Name",
        :tar_url => "Tar Url"
      )
    ])
  end

  it "renders a list of revisions" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Tar Url".to_s, :count => 2
  end
end
