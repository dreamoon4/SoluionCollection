class CreateSolutions < ActiveRecord::Migration
  def change
    create_table :solutions do |t|
      t.references :user, index: true, foreign_key: true
      t.integer :rating

      t.timestamps null: false
    end
  end
end
