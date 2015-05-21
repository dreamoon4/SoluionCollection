class ProblemsController < ApplicationController
  before_filter :get_problem_fields, :only => [:create, :update]
  before_filter :get_problem, :only => [:show, :update, :edit]

  def index
    @problems = Problem.all
  end

  def new
    @problem = Problem.new
  end
  
  def create
    Problem.create(@problem_fields)
    redirect_to problems_path
  end

  def show
  end

  def edit
    render :new
  end

  def destroy
  end

  def update
    @problem.update!(@problem_fields)
    flash[:success] = "Problem updated!"
    redirect_to problems_path
  end

  def search
    @result = Problem.search(params.require(:q), params.fetch(:page, 1))
    render json: @result.all
  end




  def get_problem_fields
    @problem_fields = params.require(:problem).permit(:title, :unique_name, :description)
  end

  def get_problem
    @problem = Problem.find(params.fetch(:id))
    # TODO redirect if no match
  end
end
