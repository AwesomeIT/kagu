class RemovePrivateFromSamples < ActiveRecord::Migration[5.0]
  def change
    remove_column :samples, :private
  end
end
