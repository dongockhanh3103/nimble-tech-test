class SessionController < ApplicationController
  before_action :authorize, only: [:new]

  def new; end

  def create
    auth = request.env['omniauth.auth']['credentials']
    email = request.env['omniauth.auth']['extra']['id_info']['email']

    user = UserOperation::CreateUser.execute(email)
    current_user = user

    session[:access_token] = auth['token']
    session[:refresh_token] = auth['refresh_token']
    session[:expires_at] = auth['expires_at']
    session[:user_email] = email

    redirect_to root_path
  end

  def destroy
    reset_session_and_redirect
  end

  private

  def authorize
    redirect_to root_path if authenticated?
  end
end
