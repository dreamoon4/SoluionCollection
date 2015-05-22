class ApplicationController < ActionController::Base
  include ApplicationHelper
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def acl_admin!
    unless session.fetch(:group, '') == 'admin'
      no_permission
    end
  end

  def acl_user!
    redirect_to user_login_path(r: request.original_url) unless login?
  end

  def acl_user_id!
    acl_user!
    if !performed? && session[:user_id].to_s != params[:id]
      # performed? means redirected to user login
      no_permission
    end
  end
end
