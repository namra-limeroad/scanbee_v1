class VendorStoreController < ApplicationController

  before_action :sb_authenticate

  def generate_dummy_order
    order_data = VendorStoreHelper.generate_dummy_order
    render :json => order_data and return
  end

  def get_barcode_data
    ip = params[:ip]
    status  = 200
    message = I18n.t 'msg_200'
    if !ip.present?
      status = 400
      message = I18n.t 'ip_400'
      url = nil
    else
      rasp_ip = ip
      filename = I18n.t 'data_file'
      url = "#{rasp_ip}/#{filename}"
    end
    status_hash = VendorStoreHelper.generate_status_msg(status,message)
    render :json => status_hash.merge({"url" => url}) and return
  end

  def generate_order_id
    status  = 200
    message = I18n.t 'msg_200'
    timestamp = params[:timestamp]
    machine_id = params[:machine_id]
    barcode_data = params[:barcode_data]
    quant_array = params[:quant_array]
    order_id = nil
    if !timestamp.present? or !machine_id.present? or !barcode_data.present? or !quant_array.present?
      status = 400
      message = I18n.t 'new_order_id_400'
    elsif !barcode_data.kind_of?(Array)
      status = 400
      message = I18n.t 'barcode_data_error'
    elsif quant_array.size != barcode_data.size
      status = 400
      message = I18n.t 'quant_prod_mismatch'
    else
      order_id = VendorStoreHelper.generate_order_id(timestamp,machine_id,barcode_data,quant_array)
    end
    status_hash = VendorStoreHelper.generate_status_msg(status,message)
    render :json => status_hash.merge({"order_data" => order_id}) and return
  end

  def get_order_data
    status  = 200
    message = I18n.t 'msg_200'
    orderid = params[:orderid]
    order_data = []
    if !orderid.present?
      status = 400
      message = I18n.t 'order_id_400'
    else
      order_data = VendorStoreHelper.get_order_data orderid
    end
    status_hash = VendorStoreHelper.generate_status_msg(status,message)
    render :json => status_hash.merge({"order_data" => order_data}) and return
  end

  def get_customer_data
    status  = 200
    message = I18n.t 'msg_200'
    customerph = params[:custph]
    customer_data = []
    if !customerph.present?
      status = 400
      message = I18n.t 'customer_id_400'
    else
      customer_data = VendorStoreHelper.get_customer_data customerph
    end
    status_hash = VendorStoreHelper.generate_status_msg(status,message)
    render :json => status_hash.merge({"customer_data" => customer_data}) and return
  end

  def generate_payment_data
    status  = 200
    message = I18n.t 'msg_200'
    payment_type = params[:payment_type]
    cust_id = params[:cust_id]
    order_id = params[:order_id]
    amount_paid = params[:amount_paid]
    payment_id = nil
    if !payment_type.present? or !cust_id.present? or !amount_paid.present? or !order_id.present?
      status = 400
      message = I18n.t 'payment_id_400'
    else
      payment_id = VendorStoreHelper.generate_payment_data payment_type, cust_id, order_id, amount_paid
    end
    status_hash = VendorStoreHelper.generate_status_msg(status,message)
    render :json => status_hash.merge({"payment_id" => payment_id}) and return
  end

  def add_prod_to_order
    status  = 200
    message = I18n.t 'msg_200'
    orderid = params[:orderid]
    order_data = params[:order_data]
    if !orderid.present? or !order_data.present?
      status = 400
      message = I18n.t 'add_prod_400'
    else
      updated_order = VendorStoreHelper.update_order(orderid,order_data)
      if order_data['quant_array'].size != order_data['barcode_data'].size
        status = 400
        message = I18n.t 'quant_prod_mismatch'
        updated_order = nil
      elsif  updated_order.empty?
        status = 400
        message = I18n.t 'add_prod_no_data'
      end
    end
    status_hash = VendorStoreHelper.generate_status_msg(status,message)
    render :json => status_hash.merge({"updated_order" => updated_order}) and return
  end

  def delete_prod_from_order
    status  = 200
    message = I18n.t 'msg_200'
    orderid = params[:orderid]
    order_data = params[:order_data]
    if !orderid.present? or !order_data.present?
      status = 400
      message = I18n.t 'add_prod_400'
    else
      updated_order = VendorStoreHelper.update_order(orderid,order_data)
      if order_data['quant_array'].size != order_data['barcode_data'].size
        status = 400
        message = I18n.t 'quant_prod_mismatch'
        updated_order = nil
      elsif  updated_order.empty?
        status = 400
        message = I18n.t 'del_prod_no_data'
      end
    end
    status_hash = VendorStoreHelper.generate_status_msg(status,message)
    render :json => status_hash.merge({"updated_order" => updated_order}) and return
  end

  def update_order_status
    orderid = params[:orderid]
    order_status = params[:order_status]
    update_status = false
    status  = 200
    message = I18n.t 'msg_200'
    if !orderid.present? or !order_status.present?
      status = 400
      message = I18n.t 'update_status_400'
    else
      update_status = VendorStoreHelper.update_order_status(orderid,order_status)
    end
    status_hash = VendorStoreHelper.generate_status_msg(status,message)
    render :json => status_hash.merge({"update_status" => update_status}) and return
  end

  def cancel_order
    orderid = params[:orderid]
    order_status = -1
    update_status = false
    status  = 200
    message = I18n.t 'msg_200'
    if !orderid.present?
      status = 400
      message = I18n.t 'order_id_400'
    else
      update_status = VendorStoreHelper.update_order_status(orderid,order_status)
    end
    status_hash = VendorStoreHelper.generate_status_msg(status,message)
    render :json => status_hash.merge({"update_status" => update_status}) and return
  end

  end
