class AddAuthTokenToSbUser < ActiveRecord::Migration
  def change
    add_column :sb_users, :auth_token, :string
  end
end
