class UserStoreController < ApplicationController

  def user_login
    username = params[:username]
    password = params[:password]
    status  = 200
    message = I18n.t 'msg_200'
    user_data = nil
    if !username.present? and !password.present?
      status = 400
      message = I18n.t 'user_auth_400'
    else
      user_data = UserStoreHelper.user_login username,password
      if !user_data.present?
        status = 400
        message = I18n.t 'user_wrong_cred'
      end
    end
    status_hash = VendorStoreHelper.generate_status_msg(status,message)
    render :json => status_hash.merge({"user_data" => user_data}) and return
  end

  def user_logout
    token = nil
    authenticate_with_http_token do |t|
      token = t
    end
    logout_status = false
    status  = 200
    message = I18n.t 'msg_200'
    if !token.present?
      status = 400
      message = I18n.t 'token_400'
    else
      logout_status = UserStoreHelper.user_logout(token)
      if (!logout_status)
        status = 400
        message = I18n.t 'msg_400'
      end
    end
    status_hash = VendorStoreHelper.generate_status_msg(status,message)
    render :json => status_hash.merge({"logout_status" => logout_status}) and return
  end
end
