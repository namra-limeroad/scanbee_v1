class AddOrderIdToSbPayment < ActiveRecord::Migration
  def change
    add_column :sb_payments, :order_id, :string
  end
end
