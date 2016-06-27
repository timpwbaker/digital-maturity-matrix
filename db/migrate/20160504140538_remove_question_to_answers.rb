class RemoveQuestionToAnswers < ActiveRecord::Migration
  def change
    remove_column :answers, :question, :string
  end
end
