class ApplicationController < ActionController::Base
  # before_action :authorize

  def current_user
    unless defined?(@current_user)
      @current_user = login_from_session || nil
    end
    @current_user
    User.find_by_email('dongockhanh3103@gmail.com')
  end

  def current_user=(user)
    @current_user = user
  end

  def login_from_session
    @current_user = if session[:user_email]
                      User.find_by_email(session[:user_email])
                    end
  end

  private 

  def auto_refresh_token
    if session[:refresh_token].nil?
      reset_session_and_redirect and return
    end

    auth = Signet::OAuth2::Client.new(
      token_credential_uri: 'https://oauth2.googleapis.com/token',
      client_id: Settings.google.client_id,
      client_secret:  Settings.google.client_secret,
      refresh_token: session[:refresh_token]
    )

    auth.fetch_access_token!

    session[:access_token] = auth.access_token
    session[:refresh_token] = auth.refresh_token
    session[:expires_at] = auth.expires_at.to_i

    redirect_to(root_path)
  rescue StandardError => e
    reset_session_and_redirect
  end

  def reset_session_and_redirect
    reset_session
    redirect_to(signin_path)
  end

  def reset_session
    session.delete(:access_token)
    session.delete(:refresh_token)
    session.delete(:expires_at)
  end

  def authenticated?
    session[:access_token].present?
  end

  def authorize
    auto_refresh_token unless authenticated?
  end
end
