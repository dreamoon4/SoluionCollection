class UsersController < ApplicationController
  # before_filter :acl_admin!, only: [:show]
  before_filter :acl_user!, only: [:setting, :save_changes]
  before_filter :get_user, only: [:show]

  def login
  end

  def show
  end

  def login_done
    unless flash['login_status']
      flash[:danger] = I18n.t('login.login_error')
      return redirect_to root_path
    end
    email = flash['login_status']['email']
    user = User.find_by_email(email)
    unless user
      user = User.create({
        email: email,
        group: 'user',
        rating: 0
      })
    end

    unless user
      flash[:danger] = I18n.t('login.login_error')
    end

    if user
      session[:user_id] = user.id
      session[:group] = user.group
      flash[:success] = I18n.t('login.success') + ' ' + email
    end 

    redirect_to root_path
  end

  def logout
    reset_session
    redirect_to root_path
  end

  def setting
  end

  def save_changes
    @user.name = params['new_name']
    @user.save!
    redirect_to user_setting_path
  end

  def get_user
    @user = User.find(session[:user_id])
  end

  def ajax_get_session_user_id
    render text: session.fetch(:user_id, '-1')
  end
end
