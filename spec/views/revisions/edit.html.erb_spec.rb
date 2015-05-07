require 'rails_helper'

RSpec.describe "revisions/edit", type: :view do
  before(:each) do
    @revision = assign(:revision, Revision.create!(
      :name => "MyString",
      :tar_url => "MyString"
    ))
  end

  it "renders the edit revision form" do
    render

    assert_select "form[action=?][method=?]", revision_path(@revision), "post" do

      assert_select "input#revision_name[name=?]", "revision[name]"

      assert_select "input#revision_tar_url[name=?]", "revision[tar_url]"
    end
  end
end
