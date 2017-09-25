class AddDigitalSizeToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :digital_size, :string
  end
end
