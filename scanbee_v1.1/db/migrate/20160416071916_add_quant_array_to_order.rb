class AddQuantArrayToOrder < ActiveRecord::Migration
  def change
    add_column :sb_orders, :quant_array, :text
  end
end
