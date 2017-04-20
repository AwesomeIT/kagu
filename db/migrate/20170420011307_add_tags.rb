class AddTags < ActiveRecord::Migration[5.0]
  def change
    create_table :tags do |t|
      t.string :name
      t.integer :count
      t.timestamps
    end

    create_table :tag_mappings do |t|
      t.references :kindable, polymorphic: true, index: true
    end

    add_reference :tag_mappings, :tag, foreign_key: true
  end
end
