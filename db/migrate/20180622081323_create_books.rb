class CreateBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :books do |t|
      t.references :user, foreign_key: true
      t.text :bookname
      t.text :author
      t.integer :price
      t.float :discount, default: 0.0
      t.string :img_url
      t.text :content
      t.boolean :sell, default: false

      t.timestamps
    end
  end
end
