class AddPasswordToSbUser < ActiveRecord::Migration
  def change
    add_column :sb_users, :password, :string
  end
end
