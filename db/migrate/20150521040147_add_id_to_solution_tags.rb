class AddIdToSolutionTags < ActiveRecord::Migration
  def change
    add_reference :solution_tags, :solution, index: true, foreign_key: true
    add_reference :solution_tags, :tag, index: true, foreign_key: true
  end
end
