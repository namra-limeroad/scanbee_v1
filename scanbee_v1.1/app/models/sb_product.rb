class SbProduct < ActiveRecord::Base
  def self.fetch_products prod_array
    products = SbProduct.find(prod_array)
    return products
  end
end
