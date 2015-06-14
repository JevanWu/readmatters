class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.references :product, index: true
      t.text :description
      t.attachment :image

      t.timestamps
    end
  end
end
