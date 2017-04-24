class RemoveIdioticIndex < ActiveRecord::Migration[5.0]
  def change
    remove_index :tag_mappings, %i(kindable_type tag_id)
    add_index :tag_mappings, %i(kindable_id tag_id), unique: true
  end
end
