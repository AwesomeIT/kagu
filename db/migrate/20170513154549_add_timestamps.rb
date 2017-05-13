class AddTimestamps < ActiveRecord::Migration[5.0]
  def change
    change_table :samples do |t|
      t.timestamps
    end
    change_table :experiments do |t|
      t.timestamps
    end
  end
end
