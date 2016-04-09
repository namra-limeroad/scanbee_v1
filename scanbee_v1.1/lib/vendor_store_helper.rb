module VendorStoreHelper
  def self.dummy_order_generator
    machine_id = rand(300..500)
    sku_quant = rand(1..30)
    sku_array = (1..4565).to_a.sample(sku_quant)
    prod_quant = Array.new(sku_quant) { rand(1...9) }
    dummy_order = {
        "machine_id" => machine_id,
        "sku_quant" => sku_quant,
        "sku_array" => sku_array,
        "prod_quant" => prod_quant
    }
    return dummy_order
  end

  def self.cart_calculator order_array, prod_quant
    cart_value = 0
    order_array.zip(prod_quant).each do |product|
      cart_value = cart_value + (product[0]["mrp"].to_f * product[1])
    end
    cart_details ={
        "cart_value" => cart_value,
        "discount" => 3336.5,
        "tax" => 455.8
    }
    return cart_details
  end
end
