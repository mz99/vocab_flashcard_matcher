class ChangeScoreToDecimal < ActiveRecord::Migration
  def change
    change_column(:scores, :score, :decimal)
  end
end
