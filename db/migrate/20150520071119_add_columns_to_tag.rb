class AddColumnsToTag < ActiveRecord::Migration
  def change
    add_column :tags, :type, :string
    add_column :tags, :name, :string
  end
end
