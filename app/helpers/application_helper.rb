module ApplicationHelper
  def login?
    session.has_key?(:user_id)
  end

  def no_permission
    flash[:danger] = I18n.t('You have no permission.')
    redirect_to '/'
  end
  
  COLORS = ['yellow', 'green', 'blue', 'orange', 'purple', 'red', 'teal']

  def tag_color(name)
    require 'zlib'
    COLORS[Zlib.crc32(name) % 7]
  end
end
