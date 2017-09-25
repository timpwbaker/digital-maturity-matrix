class RemoveColumns < ActiveRecord::Migration[5.1]
  def change
    remove_column :questions, :state_current
    remove_column :questions, :state_aspire
  end
end
