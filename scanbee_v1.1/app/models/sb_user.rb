class SbUser < ActiveRecord::Base

  def self.generate_authentication_token
    a_token = nil
    loop do
      a_token = SecureRandom.urlsafe_base64
      break unless SbUser.find_by(auth_token: a_token)
    end
    return a_token
  end

  def self.change_authentication_token userid, token
    update_token = SbUser.find(userid)
    update_token.update(
        auth_token:token
    )
    return update_token.save
  end

  def self.verify_token token
    flag  =  SbUser.where(auth_token: token).exists?
    return flag
  end

  def self.get_user_by_unp username, password
    user = SbUser.where(:email => username, :password => password).select(:id,:name,:email,:ph_number).first
    user_data = nil
    if user.present?
      token = generate_authentication_token
      token_flag = change_authentication_token user['id'], token
      if(token_flag)
        user_data = user
        user_data['auth_token'] = token
      end
    end
    return user_data
  end

  def self.destroy_authentication_token token
    user = SbUser.where(:auth_token => token).first
    destroy_token = nil
    destroy_flag = false
    if user.present?
      token_flag = change_authentication_token user['id'], destroy_token
      if (token_flag)
        destroy_flag = true
      end
    end
    return destroy_flag
  end
end
