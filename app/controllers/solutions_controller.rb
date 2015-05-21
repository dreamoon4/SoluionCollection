class SolutionsController < ApplicationController
  before_action :get_problem_list, :only => [:new]
  before_filter :get_solution, :only => [:create, :update]

  def index
    @solutions = Solution.all
  end

  def new
    @solution = Solution.new
  end

  def create
    Solution.create @solution
    redirect_to solutions_path
  end

  def edit
  end

  def destroy
  end

  def update
  end

  def get_solution
    @solution = params.require(:solution).permit(:content)
  end

  def get_problem_list
    @problems = Problem.all
  end
end
