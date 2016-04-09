class AddOrderAttrToSbOrder < ActiveRecord::Migration
  def change
    add_column :sb_orders, :cart_value, :float
    add_column :sb_orders, :cust_number, :string
    add_column :sb_orders, :payment_type, :integer
  end
end
