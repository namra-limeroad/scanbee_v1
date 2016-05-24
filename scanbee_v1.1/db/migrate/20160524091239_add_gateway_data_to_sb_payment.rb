class AddGatewayDataToSbPayment < ActiveRecord::Migration
  def change
    add_column :sb_payments, :gateway_payid, :string
    add_column :sb_payments, :gateway_status, :string
    add_column :sb_payments, :gateway_message, :string
    add_column :sb_payments, :gateway_amount, :float
  end
end
