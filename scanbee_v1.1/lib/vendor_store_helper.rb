module VendorStoreHelper
  def self.generate_dummy_order
    dummy_order = {
        "timestamp" => "2016-04-12 23:09:11",
        "barcode_data" => ["13095949", "57840055", "91749284", "84865601"],
        "quant_array" => [2, 4, 3, 4],
        "machine_id" => "21"
    }
    return dummy_order
  end

  def self.generate_status_msg status, message
    status_hash = {
        "status" => status,
        "message" => message
    }
    return status_hash
  end

  def self.generate_order_id timestamp,machine_id,barcode_data, quant_array
    return SbOrder.create_order_id timestamp, machine_id,barcode_data,quant_array
  end

  def self.get_order_data orderid
    prod_array_data = SbOrder.get_prod_data orderid
    prod_array = JSON.parse prod_array_data['prod_array']
    quant_array = JSON.parse prod_array_data['quant_array']
    prod_data = SbProduct.get_prod_by_itemid prod_array
    price_array = prod_data.map{|x| x[:mrp]}
    cart_data = get_cart_data quant_array,price_array
    order_data = {"cart_data" => cart_data, "prod_data" => prod_data}
    return order_data
  end

  def self.update_order orderid, order_data
    update_flag  = SbOrder.update_order orderid, order_data["timestamp"], order_data["machine_id"], order_data["barcode_data"], order_data["quant_array"]
    upadte_order_data = []
    if update_flag and order_data["barcode_data"] == order_data["quant_array"]
      upadte_order_data = get_order_data orderid
    end
    return upadte_order_data
  end

  def self.get_cart_data price_array, quant_array
    cart_value = 0
    price_array.zip(quant_array).each do |product|
      cart_value = cart_value + (product[0].to_f * product[1])
    end
    cart_details ={
        "amount_charge" => -1,
        "cart_value" => cart_value,
        "discount" => -1,
        "tax" => -1
    }
    return cart_details
  end

  def self.get_customer_data phone
    customer_data = SbCustomer.get_customer_by_ph(phone)
    return customer_data
  end

  def self.generate_payment_data payment_type, cust_id, order_id, amount_paid
    return SbPayment.create_new_payment payment_type, cust_id, order_id, amount_paid
  end

  def self.update_order_status orderid, order_status
    return SbOrder.update_order_status orderid,order_status
  end
end




