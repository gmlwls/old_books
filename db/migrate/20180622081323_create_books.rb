class CreateBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :books do |t|
      t.references :user, foreign_key: true
      t.text :bookname
      t.text :author
      t.string :classname
      t.integer :price
      t.string :major
      t.integer :state
      t.string :img_url
      t.integer :method
      t.text :content

      t.timestamps
    end
  end
end
