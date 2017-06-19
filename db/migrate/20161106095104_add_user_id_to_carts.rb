class AddUserIdToCarts < ActiveRecord::Migration[4.2]
  def change
    add_reference :carts, :user, index: true
  end
end
