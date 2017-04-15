class AddUserIdToApplications < ActiveRecord::Migration[5.0]
  def change
    add_reference :oauth_applications, :user, foreign_key: true
  end
end
