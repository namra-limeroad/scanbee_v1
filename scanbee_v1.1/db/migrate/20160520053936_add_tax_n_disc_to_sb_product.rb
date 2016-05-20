class AddTaxNDiscToSbProduct < ActiveRecord::Migration
  def change
    add_column :sb_products, :tax_n_disc, :text
  end
end
