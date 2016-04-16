class SbOrder < ActiveRecord::Base

  def self.create_order_id timestamp, machine_id, barcode_data, quant_array
    new_order = SbOrder.create(
        created_at:timestamp,
        machine_id: machine_id,
        prod_array: barcode_data,
        quant_array:quant_array,
        order_status: 1
    )
    return new_order.id
  end

  def self.get_prod_data order_id
    prod_data = SbOrder.where(:id => order_id).select(:id,:prod_array,:quant_array).first
    return prod_data
  end

  def self.update_order orderid, timestamp, machine_id, barcode_data, quant_array
    updated_order = SbOrder.find(orderid)
    updated_order.update(
        updated_at:timestamp,
        machine_id:machine_id,
        prod_array:barcode_data,
        quant_array:quant_array
    )
    return updated_order.save
  end

  def self.update_order_status orderid, order_status
    updated_status = SbOrder.find(orderid)
    updated_status.update(
       order_status:order_status
    )
    return updated_status.save
  end

end
