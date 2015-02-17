class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :identifier, unique: true
      t.string :state
      t.references :province, index: true
      t.references :city, index: true
      t.references :district, index: true
      t.string :street
      t.string :receiver_name

      t.references :user, index: true

      t.timestamps
    end
  end
end
