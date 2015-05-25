require 'openssl'

class HooksController < ApplicationController
  skip_before_action :authenticate, only: [:github]

  def github
    unless valid_signature?
      render text: "Signature mismatch.", status: :unauthorized
      return
    end

    GithubWorker.perform_async(request.body.string)

    render json: {status: "success"}
  end

  private

  def valid_signature?
    if github_secret = ENV['GITHUB_SECRET']
      sha1 = OpenSSL::HMAC.hexdigest(OpenSSL::Digest::Digest.new('sha1'), github_secret, request.body.string)
      signature = "sha1=" + sha1

      signature == request.headers['X-Hub-Signature']
    else
      true
    end
  end
end
