module VendorStoreHelper
  def self.generate_dummy_order
    time_utc = String(Time.now.getutc)
    non_zoned_time = time_utc.split('U')[0][0..-2]
    quantity  =  rand(3..15)
    prod_list = ["13095949", "94516487", "84865601", "24061223", "57840055", "95786650", "91749284"]
    prod_array = Array.new(quantity){prod_list.sample}
    dummy_order = {
        "timestamp" => non_zoned_time,
        "barcode_data" => prod_array,
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
    orderid = SbOrder.create_order_id timestamp, machine_id,barcode_data,quant_array
    quantity = quant_array.inject(0){|quantity,x| quantity + x }
    obf_orderid = MasterStoreHelper.obfuscate_using_xor orderid
    order_data = {"orderid" => obf_orderid, "quantity" => quantity}
    return order_data
  end

  def self.get_order_data orderid
    res_orderid = MasterStoreHelper.restore_using_xor orderid
    prod_array_data = SbOrder.get_prod_data res_orderid
    prod_array = JSON.parse prod_array_data['prod_array']
    quant_array = JSON.parse prod_array_data['quant_array']
    prod_data = SbProduct.get_prod_by_itemid prod_array
    price_array = prod_data.map{|x| x[:mrp]}
    tax_n_disc_array =  prod_data.map{|x| x[:tax_n_disc]}
    cart_data = get_cart_data quant_array,price_array,tax_n_disc_array
    for q in 0..(quant_array.length()-1)
      prod_data[q][:quantity] = quant_array[q]
    end
    order_data = {"cart_data" => cart_data, "prod_data" => prod_data}
    return order_data
  end

  def self.update_order orderid, order_data
    res_orderid = MasterStoreHelper.restore_using_xor orderid
    update_flag  = SbOrder.update_order res_orderid, order_data["timestamp"], order_data["machine_id"], order_data["barcode_data"], order_data["quant_array"]
    update_order_data = []
    if update_flag and order_data["barcode_data"].length == order_data["quant_array"].length
      update_order_data = get_order_data orderid
    end
    return update_order_data
  end

  def self.get_cart_data price_array, quant_array, tax_n_disc_array
    cart_value = 0.0
    tax = 0.0
    discount = 0.0
    tax_n_disc_data = get_tax_n_disc_data tax_n_disc_array
    price_array.zip(quant_array,tax_n_disc_array).each do |product|
      total_cost = product[0].to_f * product[1]
      tax_csv = product[2]
      temp_array  = tax_csv.split(';')
      temp_array.each do |tndval|
        tnddata = tax_n_disc_data[tndval.to_i]
        if tnddata['value_type'] == 1
          tax = tax + (tnddata['percent'].to_f * total_cost * 0.01)
        elsif tnddata['value_type'] == 2
          discount = discount + (tnddata['percent'].to_f * total_cost * 0.01)
        end
      end
      cart_value = cart_value + total_cost
    end
    amount_charge = cart_value + tax - discount
    cart_details = {
        "amount_charge" => amount_charge.round(2),
        "cart_value" => cart_value.round(1),
        "discount" => discount.round(1),
        "tax" => tax.round(1)
    }
    return cart_details
  end

  def self.get_tax_n_disc_data tax_n_disc_array
    temp_array = []
    tax_n_disc_array.each do |tndval|
      temp_array = temp_array | tndval.split(';')
    end
    tax_n_disc_data = SbTaxNDiscount.get_tax_n_disc_by_id temp_array
    tax_n_disc_hash = {}
    tax_n_disc_data.each do |tnddata|
      tax_n_disc_hash[tnddata['id']] = tnddata
    end
    return tax_n_disc_hash
  end

  def self.get_customer_data phone
    customer_data = SbCustomer.get_customer_by_ph(phone)
    return customer_data
  end

  def self.generate_payment_data payment_type, cust_id, orderid, amount_paid
    res_orderid = MasterStoreHelper.restore_using_xor orderid
    return SbPayment.create_new_payment payment_type, cust_id, res_orderid, amount_paid
  end

  def self.update_order_status orderid, order_status
    res_orderid = MasterStoreHelper.restore_using_xor orderid
    return SbOrder.update_order_status res_orderid,order_status
  end
end




