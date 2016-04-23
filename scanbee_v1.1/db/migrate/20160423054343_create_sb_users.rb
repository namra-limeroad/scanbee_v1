class CreateSbUsers < ActiveRecord::Migration
  def change
    create_table :sb_users do |t|
      t.string :name
      t.string :email
      t.string :ph_number
      t.integer :permission
      t.integer :store_id

      t.timestamps null: false
    end
  end
end
