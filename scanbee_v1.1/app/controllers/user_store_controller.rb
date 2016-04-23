class UserStoreController < ApplicationController

  def user_login
    username = params[:username]
    password = params[:password]
    status  = 200
    message = I18n.t 'msg_200'
    auth_token = nil
    if !username.present? and !password.present?
      status = 400
      message = I18n.t 'user_auth_400'
    else
      auth_token = UserStoreHelper.user_login username,password
      if !auth_token.present?
        status = 400
        message = I18n.t 'user_wrong_cred'
      end
    end
    status_hash = VendorStoreHelper.generate_status_msg(status,message)
    render :json => status_hash.merge({"auth_token" => auth_token}) and return
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
