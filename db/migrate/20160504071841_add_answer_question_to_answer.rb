class AddAnswerQuestionToAnswer < ActiveRecord::Migration
  def change
    add_column :answers, :question, :string
  end
end
