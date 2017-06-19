class RenameProductColumns < ActiveRecord::Migration[4.2]
  def change
    rename_column :products, :kind, :tags
    rename_column :products, :description, :summary
  end
end
