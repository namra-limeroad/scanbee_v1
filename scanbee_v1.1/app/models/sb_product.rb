class SbProduct < ActiveRecord::Base

  def self.create_a_product prod
    status = SbProduct.create(
        brand: prod[:brand],
        title: prod[:title],
        content: prod[:content],
        content_unit: prod[:content_unit],
        cat_name: prod[:cat_name],
        cat_id:prod[:cat_id],
        item_id:prod[:item_id],
        mrp:prod[:mrp],
        cp:prod[:cp],
        created_at: Time.now,
        updated_at: Time.now
    )
    return status.id
  end

  def self.fetch_products prod_array
    products = SbProduct.find(prod_array)
    return products
  end

  def self.get_prod_by_itemid itemid_array
    products = SbProduct.where(:item_id => itemid_array)
    return products
  end

end
