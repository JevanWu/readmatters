class AddProvinceCityDistrictToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :province, :string
    add_column :users, :city, :string
    add_column :users, :district, :string
  end
end
