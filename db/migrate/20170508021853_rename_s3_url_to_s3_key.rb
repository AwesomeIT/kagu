class RenameS3UrlToS3Key < ActiveRecord::Migration[5.0]
  def change
    rename_column :samples, :s3_url, :s3_key
  end
end
