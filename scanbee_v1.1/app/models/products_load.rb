class ProductsLoad

  @filen = './cooked/products.csv'

  def self.csv_loader
    prod_hash = SmarterCSV.process(@filen, {:col_sep => ",", :row_sep => "\n"})
    prod_hash
  end

  def self.load_hash_into_table prod
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
end
