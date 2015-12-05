require 'rails_helper'

RSpec.describe "executions/edit", type: :view do
  before(:each) do
    @execution = assign(:execution, Execution.create!(
      :revision => nil
    ))
  end

  it "renders the edit execution form" do
    render

    assert_select "form[action=?][method=?]", execution_path(@execution), "post" do

      assert_select "input#execution_revision_id[name=?]", "execution[revision_id]"
    end
  end
end
