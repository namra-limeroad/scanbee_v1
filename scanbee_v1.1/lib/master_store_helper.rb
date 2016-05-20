module MasterStoreHelper

  def self.csv_to_hasharray
    file_name = I18n.t 'products_csv'
    prod_hash = SmarterCSV.process(file_name, {:col_sep => ",", :row_sep => "\n"})
    return prod_hash
  end

  # Mersenne Primes
  def self.obfuscate_using_xor number
    key = 131071
    obfuscate = number ^ key
    return number
  end

  def self.restore_using_xor number
    key = 131071
    restore = number.to_i ^ key
    return number
  end

  def self.bulk_products_loader
    products_load_status = []
    prod_hash = csv_to_hasharray
    prod_hash.each do |prod|
      status_id = SbProduct.create_a_product(prod)
      identifier = {
          "id" => status_id,
          "title" => prod[:title],
          "sku" => prod[:item_id]
      }
      products_load_status.append(identifier)
    end
    return products_load_status
  end

end




