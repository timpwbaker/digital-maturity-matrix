class AddS3UrlToSubmissions < ActiveRecord::Migration
  def change
    add_column :submissions, :s3_url, :string
  end
end
