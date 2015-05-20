class CreateSolutionTags < ActiveRecord::Migration
  def change
    create_table :solution_tags do |t|

      t.timestamps null: false
    end
  end
end
