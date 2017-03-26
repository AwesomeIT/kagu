# frozen_string_literal: true
class SampleExperimentTable < ActiveRecord::Migration[5.0]
  def change
    create_table :experiments_samples do |t|
      t.belongs_to	:sample,	index: true,	foreign_key: true
      t.belongs_to	:experiment,	index: true,	foreign_key: true
    end
  end
end
