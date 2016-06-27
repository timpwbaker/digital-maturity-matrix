class AddOrganisationTurnoverToUser < ActiveRecord::Migration
  def change
    add_column :users, :organisation_turnover, :string
  end
end
