class AddHqCoverToBooks < ActiveRecord::Migration[5.1]
  def change
    add_column :books, :hq_cover, :string
    add_column :books, :rating, :decimal
    add_column :books, :num_of_raters, :integer
  end
end
