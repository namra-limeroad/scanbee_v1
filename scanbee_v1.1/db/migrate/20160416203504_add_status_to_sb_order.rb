class AddStatusToSbOrder < ActiveRecord::Migration
  def change
    add_column :sb_orders, :order_status, :integer
  end
end
