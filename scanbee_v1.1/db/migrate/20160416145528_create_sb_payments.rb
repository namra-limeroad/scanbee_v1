class CreateSbPayments < ActiveRecord::Migration
  def change
    create_table :sb_payments do |t|
      t.integer :payment_type
      t.string :cust_id
      t.string :amount_paid

      t.timestamps null: false
    end
  end
end
