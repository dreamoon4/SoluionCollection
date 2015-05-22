class ChangeColumnDefaultProblem < ActiveRecord::Migration
  def change
    change_column_default :problems, :rating, 0
    change_column_default :solutions, :rating, 0
  end
end
