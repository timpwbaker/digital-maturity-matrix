class CreateBenchmarkApplications < ActiveRecord::Migration[5.1]
  def change
    create_table :benchmark_applications do |t|
      t.references :user, index: true, foreign_key: true
      t.string :organisation_name
      t.string :organisation_turnover
      t.string :organisation_employees
      t.string :digital_employees
      t.boolean :opt_in

      t.timestamps null: false
    end
  end
end
