class AddColumnsToProblem < ActiveRecord::Migration
  def change
    add_column :problems, :title, :string
    add_column :problems, :unique_name, :string
    add_column :problems, :description, :string
    add_reference :problems, :user, index: true, foreign_key: true
    add_column :problems, :set_id, :integer
    add_column :problems, :rating, :integer
  end
end
