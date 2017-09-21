class DropAnswersAndTargets < ActiveRecord::Migration
  def change
    drop_table :answers
    drop_table :targets
  end
end
