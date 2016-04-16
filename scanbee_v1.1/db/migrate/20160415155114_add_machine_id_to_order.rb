class AddMachineIdToOrder < ActiveRecord::Migration
  def change
    add_column :sb_orders, :machine_id, :string
  end
end
