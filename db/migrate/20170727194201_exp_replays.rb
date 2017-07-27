class ExpReplays < ActiveRecord::Migration[5.0]
  def up
    add_column :experiments, :replays, :integer, default: 0
    change_column_null :experiments, :replays, false
  end

  def down
    remove_column :experiments, :replays
  end
end
