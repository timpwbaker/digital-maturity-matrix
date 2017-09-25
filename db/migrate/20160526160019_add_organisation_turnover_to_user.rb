class AddOrganisationTurnoverToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :organisation_turnover, :string
  end
end
