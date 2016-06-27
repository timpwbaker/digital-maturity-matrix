class AddAreaColumnToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :area, :string
  end
end
