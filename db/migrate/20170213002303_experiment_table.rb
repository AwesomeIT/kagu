class ExperimentTable < ActiveRecord::Migration[5.0]
  def change
  	create_table :experiments do |t|
  		# id of creator
      t.belongs_to	:user
      t.string 			:name, 				default: "",	null: false
      # number of times samples in the experiment can be repeated
      t.integer 		:repeats,			default: 0,		null: false
      # whether experiments are currently being shown to users
      t.boolean			:active,			default: true
    end
  end
end
