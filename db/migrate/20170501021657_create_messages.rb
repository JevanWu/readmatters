class CreateMessages < ActiveRecord::Migration[4.2]
  def change
    create_table :messages do |t|
      t.text :body
      t.datetime :read_at
      t.references :user, index: true, foreign_key: true
      t.references :conversation, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
