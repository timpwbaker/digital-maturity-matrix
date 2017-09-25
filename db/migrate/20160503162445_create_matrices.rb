class CreateMatrices < ActiveRecord::Migration[5.1]
  def change
    create_table :matrices do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
