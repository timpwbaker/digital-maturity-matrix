class AddPaidToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :paid, :boolean
  end
end
