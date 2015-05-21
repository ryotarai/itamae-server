class HooksController < ApplicationController
  def github

    GithubWorker.perform_async(request.body.string)

    render json: {status: "success"}
  end
end
