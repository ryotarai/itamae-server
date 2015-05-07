class HooksController < ApplicationController
  def github
    payload = JSON.parse(request.body.string)

    # git clone if not cloned yet
    # git fetch
    # git checkout -f rev
    # create tarball
    # create revision

    render json: {status: "success"}
  end
end
