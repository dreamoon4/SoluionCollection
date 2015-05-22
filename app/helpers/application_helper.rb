module ApplicationHelper
  def login?
    session.has_key?(:user_id)
  end
end
