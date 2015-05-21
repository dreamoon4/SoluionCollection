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

end
