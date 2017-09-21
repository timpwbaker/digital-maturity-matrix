class AddResponseJsonFieldsToSubmission < ActiveRecord::Migration
  def change
    add_column :submissions, :answers_json, :jsonb
    add_index :submissions, :answers_json, using: :gin
    add_column :submissions, :targets_json, :jsonb
    add_index :submissions, :targets_json, using: :gin
  end
end
