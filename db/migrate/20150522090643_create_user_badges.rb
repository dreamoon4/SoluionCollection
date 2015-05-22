class CreateUserBadges < ActiveRecord::Migration
  def change
    create_table :user_badges do |t|

      t.timestamps null: false
    end
  end
end
