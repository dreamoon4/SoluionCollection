class SolutionTag < ActiveRecord::Base
  belongs_to :solution
  belongs_to :tag
end
