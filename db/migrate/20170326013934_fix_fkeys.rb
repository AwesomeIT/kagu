class FixFkeys < ActiveRecord::Migration[5.0]
  def change
    add_foreign_key "experiments", "users"
    add_foreign_key "samples", "users"
    add_foreign_key "samples_experiments", "experiments"
    add_foreign_key "samples_experiments", "samples"
    add_foreign_key "scores", "experiments"
    add_foreign_key "scores", "samples"
    add_foreign_key "scores", "users"
  end
end
