class ChangePhoneToString < ActiveRecord::Migration[4.2]
  def change
    change_column :users, :phone, :string
  end
end
