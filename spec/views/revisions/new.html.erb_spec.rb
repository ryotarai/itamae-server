require 'rails_helper'

RSpec.describe "revisions/new", type: :view do
  before(:each) do
    assign(:revision, Revision.new(
      :name => "MyString",
      :tar_url => "MyString"
    ))
  end

  it "renders new revision form" do
    render

    assert_select "form[action=?][method=?]", revisions_path, "post" do

      assert_select "input#revision_name[name=?]", "revision[name]"

      assert_select "input#revision_tar_url[name=?]", "revision[tar_url]"
    end
  end
end
