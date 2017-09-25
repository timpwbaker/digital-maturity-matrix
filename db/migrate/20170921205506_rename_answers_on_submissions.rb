class RenameAnswersOnSubmissions < ActiveRecord::Migration[5.1]
  def change
    rename_column :submissions, :answers, :answers_hash
    rename_column :submissions, :targets, :targets_hash
  end
end
