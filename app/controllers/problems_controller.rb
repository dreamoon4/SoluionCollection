class ProblemsController < ApplicationController

  def index
    @problems = Problem.all
  end

  def new
  end
  
  def create
  end

  def edit
  end

  def destroy
  end
end
