class AddDigitalSizeToUser < ActiveRecord::Migration
  def change
    add_column :users, :digital_size, :string
  end
end
