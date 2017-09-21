class AddAnswersAndTargetsToSubmission < ActiveRecord::Migration
  def change
    enable_extension "hstore"
    add_column :submissions, :answers, :hstore
    add_index :submissions, :answers, using: :gin
    add_column :submissions, :targets, :hstore
    add_index :submissions, :targets, using: :gin
  end
end
