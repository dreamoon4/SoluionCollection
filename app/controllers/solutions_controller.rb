class SolutionsController < ApplicationController
  before_filter :get_solution, :only => [:create, :update]

  def index
    @solutions = Solution.all
  end

  def new
    @solution = @solution.new
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
end
