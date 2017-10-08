class RemoveNameFromSubmission < ActiveRecord::Migration[5.1]
  def up
    remove_column :submissions, :name
  end

  def down
    add_column :submissions, :name, :string
  end
end
