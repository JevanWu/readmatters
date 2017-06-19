class AddReceiverPhoneToOrders < ActiveRecord::Migration[4.2]
  def change
    add_column :orders, :receiver_phone, :string
  end
end
