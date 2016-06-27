class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :body
      t.integer :state_current
      t.integer :state_aspire
      t.references :matrix, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
