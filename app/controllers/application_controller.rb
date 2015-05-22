class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def acl_admin!
    unless session.fetch(:group, '') == 'admin'
      flash[:danger] = I18n.t('You have no permission.')
      redirect_to '/'
    end
  end

  def acl_user!
    redirect_to user_login_path(r: request.original_url) unless session.has_key?(:group)
  end
end
