class AddPayCodeToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :pay_code, :string
  end
end
