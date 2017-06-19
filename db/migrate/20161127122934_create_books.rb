class CreateBooks < ActiveRecord::Migration[4.2]
  def change
    create_table :books do |t|
      t.string :isbn
      t.string :name
      t.string :tags
      t.decimal :price
      t.text :summary
      t.string :author
      t.text :author_intro
      t.text :catalog
      t.string :original_cover
      t.string :publisher
      t.date :published_date
      t.attachment :cover
      t.json :raw_data

      t.timestamps
    end
  end
end
