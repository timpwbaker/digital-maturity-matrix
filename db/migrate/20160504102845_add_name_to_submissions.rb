class AddNameToSubmissions < ActiveRecord::Migration[5.1]
  def change
    add_column :submissions, :name, :string
  end
end
