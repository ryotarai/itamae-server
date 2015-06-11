require 'rails_helper'

RSpec.describe "logs/show", type: :view do
  before(:each) do
    @log = assign(:log, Log.create!(
      :host => "Host",
      :status => 1,
      :file_path => "File Path"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Host/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/File Path/)
  end
end
