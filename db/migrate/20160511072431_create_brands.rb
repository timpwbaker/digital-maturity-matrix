class CreateBrands < ActiveRecord::Migration[5.1]
  def change
    create_table :brands do |t|
      t.references :user, index: true, foreign_key: true
      t.string :color_a
      t.string :color_b

      t.timestamps null: false
    end
  end
end
