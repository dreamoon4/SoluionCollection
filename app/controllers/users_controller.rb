class UsersController < ApplicationController
  before_filter :acl_admin!, only: [:show]

  def login
  end

  def show
  end
end
