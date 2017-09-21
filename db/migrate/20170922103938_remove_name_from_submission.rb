class RemoveNameFromSubmission < ActiveRecord::Migration
  def up
    remove_column :submissions, :name
  end

  def down
    add_column :submissions, :name, :string
  end
end
