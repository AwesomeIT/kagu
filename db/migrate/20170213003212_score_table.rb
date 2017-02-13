class ScoreTable < ActiveRecord::Migration[5.0]
  def change
  	create_table :scores do |t|
      t.belongs_to	:user
      t.belongs_to 	:sample
      t.belongs_to	:experiment
      t.integer 		:rating,		default: 0, null: false
    end
  end
end
