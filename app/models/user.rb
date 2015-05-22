class User < ActiveRecord::Base
  has_many :problems
  has_many :solutions
  has_many :user_badges
  has_many :badges ,through: :user_badges
end
