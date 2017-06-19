class CreateProducts < ActiveRecord::Migration[4.2]
  def change
    create_table :products do |t|
      t.string :name
      t.string :kind
      t.decimal :price
      t.text :description
      t.boolean :sold
      t.attachment :cover
      t.references :user, index: true

      t.timestamps
    end
  end
end
