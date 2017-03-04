# frozen_string_literal: true
class SampleTable < ActiveRecord::Migration[5.0]
  def change
    create_table :samples do |t|
      # id of creator
      t.belongs_to	:user,				index: true,	foreign_key: true
      t.string 			:name, 				default: '',	null: false
      t.string 			:s3_url,	default: '',	null: false
      # labels for rating scale
      t.string 			:low_label
      t.string 			:high_label
      # whether only original creator or all researchers can use sample
      t.boolean			:private
    end

    add_index :samples, :s3_url, unique: true
  end
end
