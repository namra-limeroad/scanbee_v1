class SbPayment < ActiveRecord::Base

  def self.create_new_payment payment_type, cust_id, order_id, amount_paid, g_status, g_message, g_id, g_amount
    new_payment = SbPayment.create(
        payment_type: payment_type,
        cust_id: cust_id,
        order_id: order_id,
        amount_paid:amount_paid,
        gateway_amount:g_amount,
        gateway_status:g_status,
        gateway_message:g_message,
        gateway_payid:g_id
    )
    return new_payment.id
  end

end
