class CreateSbCustomers < ActiveRecord::Migration
  def change
    create_table :sb_customers do |t|
      t.string :name
      t.string :phone
      t.string :email_id

      t.timestamps null: false
    end
  end
end
