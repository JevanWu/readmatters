class AddColumnSellerIdToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :seller_id, :integer
    add_index :orders, :seller_id
  end
end
