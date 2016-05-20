class CreateSbTaxNDiscounts < ActiveRecord::Migration
  def change
    create_table :sb_tax_n_discounts do |t|
      t.string :name
      t.integer :type
      t.float :percent

      t.timestamps null: false
    end
  end
end
