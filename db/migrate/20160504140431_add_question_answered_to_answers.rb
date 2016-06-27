class AddQuestionAnsweredToAnswers < ActiveRecord::Migration
  def change
    add_column :answers, :question_answered, :string
  end
end
