class CreateUserInfos < ActiveRecord::Migration
  def change
    create_table :user_infos do |t|
      t.references :user, index: true, foreign_key: true
      t.string :category
      t.string :value

      t.timestamps null: false
    end
  end
end
