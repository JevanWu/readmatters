class AddReceiverPhoneToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :receiver_phone, :string
  end
end
