class ChangeScoreInAnswers < ActiveRecord::Migration
  def change
    change_column :answers, :score, :float
  end
end
