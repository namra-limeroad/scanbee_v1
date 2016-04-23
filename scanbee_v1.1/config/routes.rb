Rails.application.routes.draw do

  root :to => 'vendor_store#generate_dummy_order'


  match 'sbapi/generate_dummy_order'  => 'vendor_store#generate_dummy_order', via: [:get, :post]
  match 'sbapi/get_barcode_data'  => 'vendor_store#get_barcode_data', via: [:get, :post]
  match 'sbapi/get_order_data'  => 'vendor_store#get_order_data', via: [:get, :post]
  match 'sbapi/get_customer_data'  => 'vendor_store#get_customer_data', via: [:get, :post]

  match 'sbapi/bulk_products_loader'  => 'master_store#bulk_products_loader', via: :post
  match 'sbapi/generate_order_id'  => 'vendor_store#generate_order_id', via: :post
  match 'sbapi/generate_payment_data'  => 'vendor_store#generate_payment_data', via: :post
  match 'sbapi/add_prod_to_order'  => 'vendor_store#add_prod_to_order', via: :post
  match 'sbapi/user_login'  => 'user_store#user_login', via: :post
  match 'sbapi/user_logout'  => 'user_store#user_logout', via: :post
  match 'sbapi/delete_prod_from_order'  => 'vendor_store#delete_prod_from_order', via: :post
  match 'sbapi/update_order_status'  => 'vendor_store#update_order_status', via: :post
  match 'sbapi/cancel_order'  => 'vendor_store#cancel_order', via: :post
end
