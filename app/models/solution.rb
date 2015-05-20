class Solution < ActiveRecord::Base
  belongs_to :user
  has_many :solution_tags
  has_many :tags, through: :solution_tags
end
