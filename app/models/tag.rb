class Tag < ActiveRecord::Base
  has_many :problem_tags
  has_many :problem, through: :problem_tags
  has_many :solution_tags
  has_many :solution, through: :solution_tags
end
