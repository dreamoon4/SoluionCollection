class Problem < ActiveRecord::Base
  belongs_to :user
  has_many :problem_tags
  has_many :tags, through: :problem_tags
end
