class UsersController < ApplicationController
  before_filter :acl_admin!, only: [:show]

  def login
  end

  def show
  end

  def login_done
    unless flash['login_status']
      flash[:danger] = I18n.t('login.login_error')
      redirect_to root_path && return
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
end
