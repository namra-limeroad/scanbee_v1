class CreateSbOrders < ActiveRecord::Migration
  def change
    create_table :sb_orders do |t|
      t.text :prod_array
      t.timestamps null: false
    end
  end
end
