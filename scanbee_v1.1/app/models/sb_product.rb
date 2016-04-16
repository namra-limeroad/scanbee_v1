class SbProduct < ActiveRecord::Base
  def self.fetch_products prod_array
    products = SbProduct.find(prod_array)
    return products
  end

  def self.get_prod_by_itemid itemid_array
    products = SbProduct.where(:item_id => itemid_array)
    return products
  end
end
