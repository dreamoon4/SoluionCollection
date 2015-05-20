class CreateProblems < ActiveRecord::Migration
  def change
    create_table :problems do |t|

      t.timestamps null: false
    end
  end
end
