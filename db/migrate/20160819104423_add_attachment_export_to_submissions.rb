class AddAttachmentExportToSubmissions < ActiveRecord::Migration
  def self.up
    change_table :submissions do |t|
      t.attachment :export
    end
  end

  def self.down
    remove_attachment :submissions, :export
  end
end
