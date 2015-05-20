class CreateProblemTags < ActiveRecord::Migration
  def change
    create_table :problem_tags do |t|

      t.timestamps null: false
    end
  end
end
