class AddProblemToSolution < ActiveRecord::Migration
  def change
    add_reference :solutions, :problem, index: true, foreign_key: true
  end
end
