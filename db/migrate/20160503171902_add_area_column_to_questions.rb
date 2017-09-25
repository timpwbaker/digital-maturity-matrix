class AddAreaColumnToQuestions < ActiveRecord::Migration[5.1]
  def change
    add_column :questions, :area, :string
  end
end
