class Tag < ActiveRecord::Base
  has_many :problem_tags
  has_many :problem, through: :problem_tags
  has_many :solution_tags
  has_many :solution, through: :solution_tags

  def self.search(keyword, category)
    if (category.nil? || category.empty?)
      where "name LIKE :keyword", keyword: "%#{keyword}%"
    else
      where "category = :category AND name LIKE :keyword", keyword: "%#{keyword}%", category: category
    end
  end
end
