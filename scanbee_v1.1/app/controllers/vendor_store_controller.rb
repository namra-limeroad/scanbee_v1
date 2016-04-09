class VendorStoreController < ApplicationController

  ##Rendering JSON
  def show_order
    order_array = VendorStoreHelper.dummy_order_generator
    render :json => order_array
  end

  def show_order_details
    order_array = VendorStoreHelper.dummy_order_generator
    prod_details = SbProduct.fetch_products(order_array['sku_array'])
    prod_quant =  order_array['prod_quant']
    cart_details = VendorStoreHelper.cart_calculator(prod_details, prod_quant)
    render :json => {"cart_details" => cart_details,"prod_quant" => prod_quant, "prod_details" => prod_details}
  end

  ##Rendering Pages
  def show_scanning_page
    render 'scanbee/scanning'
  end

  def show_listing_page
    render 'scanbee/listing'
  end

  def show_payment_page
    render 'scanbee/payment'
  end

end
