module UserStoreHelper

  def self.user_login username,password
    user_data = SbUser.get_user_by_unp username,password
    # user_data['id'] = MasterStoreHelper.obfuscate_using_xor user_data['id']
    return user_data
  end

  def self.user_logout token
    logout_flag  =  SbUser.destroy_authentication_token token
    return logout_flag
  end
end
