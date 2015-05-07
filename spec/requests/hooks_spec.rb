require "rails_helper"

RSpec.describe HooksController, type: :request do
  describe "/hooks/github" do
    let(:payload) do
      # https://developer.github.com/v3/activity/events/types/#pushevent
      {
        'ref' => 'refs/heads/apply',
        'head_commit' => {
          'id' => 'deadbeef',
        },
        'repository' => {
          'clone_url' => 'https://github.com/baxterthehacker/public-repo.git',
        },
      }
    end

    it "creates a new revision" do
      post "/hooks/github", payload.to_json
    end
  end
end

