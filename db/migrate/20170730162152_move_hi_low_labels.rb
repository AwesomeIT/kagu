class MoveHiLowLabels < ActiveRecord::Migration[5.0]
  def up
    remove_column :samples, :low_label
    remove_column :samples, :high_label

    add_column :experiments, :low_label, :string
    add_column :experiments, :high_label, :string
  end

  def down
    # no-op
  end
end
