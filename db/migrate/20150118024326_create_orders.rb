class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.text :address
      t.string :pay_method
      t.references :user, index: true

      t.timestamps
    end
  end
end
