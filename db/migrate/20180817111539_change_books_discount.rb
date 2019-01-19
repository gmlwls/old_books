class ChangeBooksDiscount < ActiveRecord::Migration[5.1]
  def change
  	change_column_default :books, :discount, -1.0
  end
end
