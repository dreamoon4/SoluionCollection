module ApplicationHelper
  def login?
    session.has_key?(:user_id)
  end

  def no_permission
    flash[:danger] = I18n.t('You have no permission.')
    redirect_to '/'
  end
end
