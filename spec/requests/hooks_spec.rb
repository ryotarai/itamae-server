require "rails_helper"

RSpec.describe HooksController, type: :request do
  describe "/hooks/github" do
    let(:payload) do
      # https://developer.github.com/v3/activity/events/types/#pushevent
      {
        'ref' => 'refs/heads/apply',
        'head_commit' => {
          'id' => '9049f1265b7d61be4a8904a9a27120d2064dab3b',
        },
        'repository' => {
          'clone_url' => 'https://github.com/baxterthehacker/public-repo.git',
        },
      }
    end

    before do
      FileUtils.rm_rf(GithubWorker::WORKSPACE_DIR)
    end

    it "creates a new revision" do
      post "/hooks/github", payload.to_json
      expect do
        GithubWorker.drain
      end.to change { Revision.count }.by(1)
      expect(Revision.last.absolute_file_path).to be_exist
    end
  end
end

