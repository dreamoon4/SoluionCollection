class LoginController < ApplicationController
  def success
    flash['login_status'] = {
      provider: request.env['omniauth.auth'][:provider],
      uid: request.env['omniauth.auth'][:uid],
      email: request.env['omniauth.auth'].fetch(:info, {}).fetch(:email, nil)
    }
    flash['login_status'][:email] ||= request.env['omniauth.auth']
      .fetch(:extra, {})
      .fetch(:raw_info, {})
      .fetch(:email, nil)
    redirect_to login_complete_path
  end
  def failure
    flash['login_status'] = nil
    redirect_to login_complete_path
  end
end
