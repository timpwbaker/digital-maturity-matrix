class DropBenchmarkApplications < ActiveRecord::Migration
  def change
  	drop_table :benchmark_applications
  end
end
