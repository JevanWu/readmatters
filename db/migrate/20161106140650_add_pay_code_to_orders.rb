class AddPayCodeToOrders < ActiveRecord::Migration[4.2]
  def change
    add_column :orders, :pay_code, :string
  end
end
