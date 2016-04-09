class CreateSbProducts < ActiveRecord::Migration
  def change
    create_table :sb_products do |t|
      t.string :brand
      t.text :title
      t.float :content
      t.float :content_unit
      t.string :cat_name
      t.integer :cat_id
      t.string :item_id
      t.float :mrp
      t.float :cp
      t.timestamps null: false
    end
  end
end