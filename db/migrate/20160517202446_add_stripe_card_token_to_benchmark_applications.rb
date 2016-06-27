class AddStripeCardTokenToBenchmarkApplications < ActiveRecord::Migration
  def change
    add_column :benchmark_applications, :card_token, :string
  end
end
