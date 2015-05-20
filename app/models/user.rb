class User < ActiveRecord::Base
  has_many :problems
  has_many :solutions
end
