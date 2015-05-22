class AddProblemAndTagToProblemTag < ActiveRecord::Migration
  def change
    add_reference :problem_tags, :problem, index: true, foreign_key: true
    add_reference :problem_tags, :tag, index: true, foreign_key: true
  end
end
