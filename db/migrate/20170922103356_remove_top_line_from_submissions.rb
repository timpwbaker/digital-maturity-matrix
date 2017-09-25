class RemoveTopLineFromSubmissions < ActiveRecord::Migration[5.1]
  def up
    remove_column :submissions, :top_line_current_hash
    remove_column :submissions, :top_line_target_hash
  end

  def down
    enable_extension "hstore"
    add_column :submissions, :top_line_current_hash, :hstore
    add_index :submissions, :top_line_current_hash, using: :gin
    add_column :submissions, :top_line_target_hash, :hstore
    add_index :submissions, :top_line_target_hash, using: :gin
  end
end
