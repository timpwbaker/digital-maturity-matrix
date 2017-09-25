class AddApiKeyToUser < ActiveRecord::Migration[5.1]
  def up
    add_column :users, :api_key, :string
  end

  def down
    remove_column :users, :api_key
  end
end
