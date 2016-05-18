class AddQuantityToSbProduct < ActiveRecord::Migration
  def change
    add_column :sb_products, :quantity, :integer
  end
end
