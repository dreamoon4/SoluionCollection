class ProblemsController < ApplicationController
  before_filter :get_problem_fields, :only => [:create, :update]
  before_filter :get_problem, :only => [:show, :update, :edit, :like, :dislike]
  before_filter :acl_user!, :only => [:new, :create]

  def index
    if params.has_key?(:search)
      @problems = Problem.search_all(params.fetch(:search))
    else
      @problems = Problem.all
    end
  end

  def new
    @problem = Problem.new
  end
  
  def create
    @problem_fields['user_id'] = session['user_id']
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
    @problems = Problem.search(params.require(:q), params.fetch(:page, 1))
    @problems = @problems.all
    @result = []
    for prob in @problems do
      @result << [prob, prob.solutions.all]
    end
    render json: @result
  end

  def like
    @problem.rating += 1
    @problem.save!
    render json: { count: @problem.rating, id: @problem.id }
  end

  def dislike
    @problem.rating -= 1
    @problem.save!
    render json: { count: @problem.rating, id: @problem.id }
  end


  def get_problem_fields
    @problem_fields = params.require(:problem).permit(:title, :unique_name, :description, :user_id)
  end

  def get_problem
    @problem = Problem.find(params.fetch(:id))
    # TODO redirect if no match
  end
end
