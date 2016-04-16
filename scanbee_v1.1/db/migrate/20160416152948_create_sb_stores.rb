class CreateSbStores < ActiveRecord::Migration
  def change
    create_table :sb_stores do |t|
      t.string :store_name
      t.integer :store_master_id
      t.string :store_phone

      t.timestamps null: false
    end
  end
end
