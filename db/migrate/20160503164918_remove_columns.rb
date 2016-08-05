class RemoveColumns < ActiveRecord::Migration
  def change
    remove_column :questions, :state_current
    remove_column :questions, :state_aspire
  end
end
