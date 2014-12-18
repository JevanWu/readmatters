class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :kind
      t.decimal :price
      t.text :description
      t.boolean :sold
      t.references :user, index: true

      t.timestamps
    end
  end
end
