class AddOrganisationSizeToUser < ActiveRecord::Migration
  def change
    add_column :users, :organisation_size, :string
  end
end
