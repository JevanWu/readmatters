class AddStatusToProducts < ActiveRecord::Migration[4.2]
  def change
    add_column :products, :status, :string, default: "initial"
    remove_column :products, :sold
  end
end
