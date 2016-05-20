class RenameTypeInSbTaxNDiscount < ActiveRecord::Migration
  def change
    rename_column :sb_tax_n_discounts, :type, :value_type
  end
end
