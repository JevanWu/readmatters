class AddStatusToProducts < ActiveRecord::Migration
  def change
    add_column :products, :status, :string, default: "initial"
    remove_column :products, :sold
  end
end
