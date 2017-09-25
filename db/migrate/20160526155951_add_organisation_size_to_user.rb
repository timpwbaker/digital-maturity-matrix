class AddOrganisationSizeToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :organisation_size, :string
  end
end
