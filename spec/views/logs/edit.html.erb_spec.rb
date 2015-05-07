require 'rails_helper'

RSpec.describe "logs/edit", type: :view do
  before(:each) do
    @log = assign(:log, Log.create!(
      :host => "MyString",
      :status => 1,
      :file_path => "MyString"
    ))
  end

  it "renders the edit log form" do
    render

    assert_select "form[action=?][method=?]", log_path(@log), "post" do

      assert_select "input#log_host[name=?]", "log[host]"

      assert_select "input#log_status[name=?]", "log[status]"

      assert_select "input#log_file_path[name=?]", "log[file_path]"
    end
  end
end
