require 'rails_helper'

RSpec.describe "logs/new", type: :view do
  before(:each) do
    assign(:log, Log.new(
      :host => "MyString",
      :status => 1,
      :file_path => "MyString"
    ))
  end

  it "renders new log form" do
    render

    assert_select "form[action=?][method=?]", logs_path, "post" do

      assert_select "input#log_host[name=?]", "log[host]"

      assert_select "input#log_status[name=?]", "log[status]"

      assert_select "input#log_file_path[name=?]", "log[file_path]"
    end
  end
end
