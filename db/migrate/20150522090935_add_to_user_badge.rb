class AddToUserBadge < ActiveRecord::Migration
  def change
    add_reference :user_badges, :user, index: true, foreign_key: true
    add_reference :user_badges, :badge, index: true, foreign_key: true
  end
end
