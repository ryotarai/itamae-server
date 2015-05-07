require 'rails_helper'

RSpec.describe "logs/index", type: :view do
  before(:each) do
    assign(:logs, [
      Log.create!(
        :host => "Host",
        :status => 1,
        :file_path => "File Path"
      ),
      Log.create!(
        :host => "Host",
        :status => 1,
        :file_path => "File Path"
      )
    ])
  end

  it "renders a list of logs" do
    render
    assert_select "tr>td", :text => "Host".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "File Path".to_s, :count => 2
  end
end
