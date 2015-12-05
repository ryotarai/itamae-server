require 'rails_helper'

RSpec.describe "executions/new", type: :view do
  before(:each) do
    assign(:execution, Execution.new(
      :revision => nil
    ))
  end

  it "renders new execution form" do
    render

    assert_select "form[action=?][method=?]", executions_path, "post" do

      assert_select "input#execution_revision_id[name=?]", "execution[revision_id]"
    end
  end
end
