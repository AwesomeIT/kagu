class ScoreTable < ActiveRecord::Migration[5.0]
  def change
  	create_table :scores do |t|
      t.belongs_to	:user,				index: true,	foreign_key: true
      t.belongs_to 	:sample,			index: true,	foreign_key: true
      t.belongs_to	:experiment,	index: true,	foreign_key: true
      t.integer 		:rating,			default: 0, 	null: false
    end
  end
end
