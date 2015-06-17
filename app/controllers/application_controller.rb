class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate

  def authenticate
    if !current_user && (auth_provider = ENV['AUTH_PROVIDER'])
      redirect_to "/auth/#{auth_provider}"
    end
  end

  def current_user
    if user_id = session[:user_id]
      @current_user ||= User.find(user_id)
    end
  end

  def current_user=(user)
    @current_user = user
    session[:user_id] = @current_user.id
  end
end
