class AddS3UrlToSubmissions < ActiveRecord::Migration[5.1]
  def change
    add_column :submissions, :s3_url, :string
  end
end
