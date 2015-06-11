class SessionsController < ApplicationController
  skip_before_action :authenticate, only: [:create]

  def create
    @user = User.find_from_auth_hash(auth_hash)
    unless @user
      render text: "HostExecutionging in failed. Please ask administrator.", status: :unauthorized
      return
    end

    self.current_user = @user
    redirect_to '/'
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end
