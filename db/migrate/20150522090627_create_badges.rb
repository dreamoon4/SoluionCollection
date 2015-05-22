class CreateBadges < ActiveRecord::Migration
  def change
    create_table :badges do |t|
      t.string :title
      t.string :description
      t.integer :points
      t.string :img_link

      t.timestamps null: false
    end
  end
end
