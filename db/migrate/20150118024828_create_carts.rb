class CreateCarts < ActiveRecord::Migration[4.2]
  def change
    create_table :carts do |t|

      t.timestamps
    end
  end
end
