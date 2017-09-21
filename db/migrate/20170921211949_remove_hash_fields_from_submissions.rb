class RemoveHashFieldsFromSubmissions < ActiveRecord::Migration
  def change
    remove_column :submissions, :answers_hash
    remove_column :submissions, :targets_hash
  end
end
