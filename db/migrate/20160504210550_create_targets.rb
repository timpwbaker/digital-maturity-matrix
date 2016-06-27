class CreateTargets < ActiveRecord::Migration
  def change
    create_table :targets do |t|
      t.string :question_answered
      t.string :choice
      t.references :question, index: true, foreign_key: true
      t.references :submission, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
