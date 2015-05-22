class SolutionsController < ApplicationController
  before_action :get_problem_list, :only => [:new]
  before_action :get_tag_list, :only => [:new]
  before_action :get_solution, :only => [:show, :like, :dislike]
  before_filter :get_solution_params, :only => [:create, :update]
  before_filter :acl_user!, :only => [:create, :new]

  def index
    @solutions = Solution.all
  end

  def new
    @solution = Solution.new
    @solution.problem = Problem.find_by_unique_name(params.fetch(:pname)) if params.has_key?(:pname)
  end

  def create
    p @solution_params
    @solution_params['user_id'] = session['user_id']
    @solution = Solution.new(@solution_params)
    
    @solution.problem = Problem.find_by_unique_name(params.require(:problem_unique_name))
    params.require(:tag_name).split(',').map do |name|
      tag = Tag.find_or_create_by name: name
      SolutionTag.create solution: @solution, tag: tag
    end
    @solution.save!
    redirect_to problems_path
  end

  def like
    @solution.rating += 1
    @solution.save!
    render json: { count: @solution.rating, id: @solution.id }
  end

  def dislike
    @solution.rating -= 1
    @solution.save!
    render json: { count: @solution.rating, id: @solution.id }
  end

  def edit
  end

  def destroy
  end

  def update
  end

  def get_solution_params
    @solution_params = params.require(:solution).permit(:content)
  end

  def get_solution
    @solution= Solution.find(params.fetch(:id))
    # TODO redirect if no match
  end

  def get_problem_list
    @problems = Problem.all
  end

  def get_tag_list
    @tags = Tag.all
  end
end
