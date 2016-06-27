class AddScoreToTarget < ActiveRecord::Migration
  def change
    add_column :targets, :score, :integer
  end
end
