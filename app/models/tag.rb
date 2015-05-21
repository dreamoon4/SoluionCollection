class Tag < ActiveRecord::Base
  has_many :problem_tags
  has_many :problem, through: :problem_tags
  has_many :solution_tags
  has_many :solution, through: :solution_tags

  def self.search(keyword)
    where "name LIKE ?", "%#{keyword}%"
  end
end
