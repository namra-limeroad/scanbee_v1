class MasterStoreController < ApplicationController

  def bulk_products_loader
    status  = 200
    message = I18n.t 'msg_200'
    status_hash = VendorStoreHelper.generate_status_msg(status,message)
    products_status_array = MasterStoreHelper.bulk_products_loader
    render :json => status_hash.merge({"products_status" => products_status_array}) and return
  end

end
