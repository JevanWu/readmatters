class AddMoreProductColumns < ActiveRecord::Migration
  def change
    add_column :products, :isbn, :string 
    add_column :products, :original_cover, :string 
    add_column :products, :author, :string 
    add_column :products, :author_intro, :text 
    add_column :products, :catalog, :text 
    add_column :products, :publisher, :string 
    add_column :products, :published_date, :date 
    add_column :products, :raw_data, :json
  end
end
