require 'rails_helper'

RSpec.describe "hosts/edit", type: :view do
  before(:each) do
    @host = assign(:host, Host.create!(
      :name => "MyString"
    ))
  end

  it "renders the edit host form" do
    render

    assert_select "form[action=?][method=?]", host_path(@host), "post" do

      assert_select "input#host_name[name=?]", "host[name]"
    end
  end
end
