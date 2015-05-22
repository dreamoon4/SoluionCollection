class Badge < ActiveRecord::Base
  has_many :user_badges
  has_many :users ,through: :user_badges
end
