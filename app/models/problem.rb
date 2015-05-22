class Problem < ActiveRecord::Base
  belongs_to :user
  has_many :solutions
  has_many :problem_tags
  has_many :tags, through: :problem_tags

  require 'uri'

  def link?
    uri = URI.parse(description)
    uri.kind_of?(URI::HTTP)
  rescue URI::InvalidURIError
    false
  end

  def self.search(search, page = 1)
    where("unique_name LIKE :search OR title LIKE :search", search: "%#{search}%")
      .offset((page-1)*5)
      .limit(5)
  end

  def self.search_all(search)
    where("unique_name LIKE :search OR title LIKE :search", search: "%#{search}%")
  end

end
