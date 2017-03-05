class AddHypothesisToSamples < ActiveRecord::Migration[5.0]
  def up
    add_column(:samples, :hypothesis, :string)
  end

  def down
    remove_column(:samples, :hypothesis)
  end
end
