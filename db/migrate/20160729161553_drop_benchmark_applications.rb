class DropBenchmarkApplications < ActiveRecord::Migration[5.1]
  def change
    drop_table :benchmark_applications
  end
end
