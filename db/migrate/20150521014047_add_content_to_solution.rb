class AddContentToSolution < ActiveRecord::Migration
  def change
    add_column :solutions, :content, :string
  end
end
