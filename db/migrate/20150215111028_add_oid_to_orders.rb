class AddOidToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :oid, :string, unique: true
  end
end
