class SbPayment < ActiveRecord::Base

  def self.create_new_payment payment_type, cust_id, order_id, amount_paid
    new_payment = SbPayment.create(
        payment_type: payment_type,
        cust_id: cust_id,
        order_id: order_id,
        amount_paid:amount_paid
    )
    return new_payment.id
  end

end
