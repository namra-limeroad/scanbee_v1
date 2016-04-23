class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery

  helper_method :sb_authenticate

  protected

  def sb_authenticate
    authenticate_token || render_unauthorized
  end

  def authenticate_token
    authenticate_with_http_token do |token|
      SbUser.verify_token token
    end
  end

  def render_unauthorized
    self.headers['WWW-Authenticate'] = 'Token realm="Scanbee"'
    status = 401
    message = I18n.t 'user_auth_402'
    status_hash = VendorStoreHelper.generate_status_msg(status,message)
    render json: status_hash
  end

end
