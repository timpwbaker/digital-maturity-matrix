class ChangeScoreInTargets < ActiveRecord::Migration
  def change
    change_column :targets, :score, :float
  end
end
