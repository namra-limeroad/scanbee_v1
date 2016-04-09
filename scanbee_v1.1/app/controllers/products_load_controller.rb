class ProductsLoadController < ApplicationController
  @prod = []
  def status
    prod_hash = ProductsLoad.csv_loader
    prod_hash.each do |prod|
      status_id = ProductsLoad.load_hash_into_table prod
      @prod = status_id
    end
  end
end
