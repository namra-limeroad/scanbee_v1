class ChangeContentUnitInSbProduct < ActiveRecord::Migration
  def change
    change_column :sb_products, :content_unit, :string
  end
end
