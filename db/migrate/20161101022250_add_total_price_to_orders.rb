class AddTotalPriceToOrders < ActiveRecord::Migration[4.2]
  def change
    add_column :orders, :total_price, :decimal
  end
end
