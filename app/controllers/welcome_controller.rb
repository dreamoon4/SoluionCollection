class WelcomeController < ApplicationController
  def index
    flash[:hello] = "123"
    redirect_to problems_path
  end
end
