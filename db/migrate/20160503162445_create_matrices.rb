class CreateMatrices < ActiveRecord::Migration
  def change
    create_table :matrices do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
