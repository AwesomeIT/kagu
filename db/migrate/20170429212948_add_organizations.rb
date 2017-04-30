class AddOrganizations < ActiveRecord::Migration[5.0]
  def change
    create_table :organizations do |t|
      t.string :name
      t.timestamps
    end

    add_index :organizations, :name, unique: true

    create_table :organization_mappings do |t|
      t.references :kindable, polymorphic: true, index: true
    end

    add_reference :organization_mappings, :organization, foreign_key: true

    add_index :organization_mappings,
      %i(kindable_id kindable_type)
  end
end