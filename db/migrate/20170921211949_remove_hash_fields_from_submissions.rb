class RemoveHashFieldsFromSubmissions < ActiveRecord::Migration[5.1]
  def change
    remove_column :submissions, :answers_hash
    remove_column :submissions, :targets_hash
  end
end
