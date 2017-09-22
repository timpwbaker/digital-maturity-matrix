class RemoveExportFromSubmissions < ActiveRecord::Migration
  def up
    remove_attachment :submissions, :export
  end

  def down
    change_table :submissions do |t|
      t.attachment :export
    end
  end
end
