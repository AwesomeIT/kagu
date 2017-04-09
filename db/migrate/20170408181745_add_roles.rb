class AddRoles < ActiveRecord::Migration[5.0]
  def change
    # Permissions / scopes
    create_table :roles do |t|
      t.string :name
      t.string :description
      t.timestamps
    end

    add_index :roles, :name, unique: true

    create_table :roles_users, id: false do |t|
      t.belongs_to :role, index: true, foreign_key: true
      t.belongs_to :user, index: true, foreign_key: true
    end
  end
end
