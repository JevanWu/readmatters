class SetProductSoldDefaultToFalse < ActiveRecord::Migration[4.2]
  def change
    change_column_default(:products, :sold, false)
  end
end
