class SampleExperimentTable < ActiveRecord::Migration[5.0]
  def change
  	create_table :samples_experiments do |t|
      t.belongs_to	:sample
      t.belongs_to 	:experiment
    end
  end
end
