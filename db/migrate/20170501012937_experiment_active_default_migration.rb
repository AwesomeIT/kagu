class ExperimentActiveDefaultMigration < ActiveRecord::Migration[5.0]
  def change
    change_column_default :experiments, :active, false
  end
end
