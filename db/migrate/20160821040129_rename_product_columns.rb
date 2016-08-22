class RenameProductColumns < ActiveRecord::Migration
  def change
    rename_column :products, :kind, :tags
    rename_column :products, :description, :summary
  end
end
