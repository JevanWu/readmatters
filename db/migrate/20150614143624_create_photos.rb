class CreatePhotos < ActiveRecord::Migration[4.2]
  def change
    create_table :photos do |t|
      t.references :product, index: true
      t.text :description
      t.attachment :image

      t.timestamps
    end
  end
end
