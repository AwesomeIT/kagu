class CreateIndexOrgMappings < ActiveRecord::Migration[5.0]
  def change
    add_index :organization_mappings, 
              %w(organization_id kindable_type kindable_id),
              unique: true,
              name: 'org_maps_org_id_kindable_unique'
  end
end
