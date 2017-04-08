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
      t.belongs_to :roles, index: true
      t.belongs_to :users, index: true
    end
  end
end
