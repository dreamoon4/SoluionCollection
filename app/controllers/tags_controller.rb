class TagsController < ApplicationController
  before_filter :get_tag, :only => [:create, :update]

  def index
    @tags = Tag.all
  end

  def new
    @tag = @tag.new
  end

  def create
    Tag.create @tag
    redirect_to tags_path
  end

  def edit
  end

  def destroy
  end

  def update
  end

  def get_tag
    @tag = params.require(:tag).permit(:content)
  end
end
