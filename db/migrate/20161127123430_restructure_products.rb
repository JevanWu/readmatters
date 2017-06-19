class RestructureProducts < ActiveRecord::Migration[4.2]
  def change
    change_table :products do |t|
      t.remove :name
      t.remove :isbn
      t.remove :original_cover
      t.remove :author
      t.remove :author_intro
      t.remove :catalog
      t.remove :publisher
      t.remove :published_date
      t.remove :raw_data
      t.references :book, index: true
    end
  end
end
