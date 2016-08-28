class SetProductSoldDefaultToFalse < ActiveRecord::Migration
  def change
    change_column_default(:products, :sold, false)
  end
end
