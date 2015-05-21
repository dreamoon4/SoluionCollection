class ProblemsController < ApplicationController
  before_filter :get_problem, :only => [:create, :update]

  def index
    @problems = Problem.all
  end

  def new
    @problem = Problem.new
  end
  
  def create
    Problem.create(@problem)
    redirect_to problems_path
  end

  def show
  end

  def edit
  end

  def destroy
  end

  def update
  end

  def get_problem
    @problem = params.require(:problem).permit(:title, :unique_name, :description)
  end
end
