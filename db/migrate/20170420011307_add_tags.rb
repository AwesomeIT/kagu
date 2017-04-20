class AddTags < ActiveRecord::Migration[5.0]
  def change
    create_table :tags do |t|
      t.string :name
      t.integer :count
      t.timestamps
    end

    add_index :tags, :name, unique: true

    create_table :tag_mappings do |t|
      t.references :kindable, polymorphic: true, index: true
    end
    add_reference :tag_mappings, :tag, foreign_key: true

    add_index :tag_mappings, %i(kindable_type tag_id), unique: true
  end
end
