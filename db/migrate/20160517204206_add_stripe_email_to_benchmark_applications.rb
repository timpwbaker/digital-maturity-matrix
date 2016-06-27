class AddStripeEmailToBenchmarkApplications < ActiveRecord::Migration
  def change
    add_column :benchmark_applications, :email, :string
  end
end
