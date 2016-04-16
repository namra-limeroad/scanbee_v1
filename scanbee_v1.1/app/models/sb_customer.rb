class SbCustomer < ActiveRecord::Base

  def self.create_customer name, phone, email
    new_customer = SbCustomer.create(
        name:name,
        phone: phone,
        email_id: email,
    )
    return new_customer.id
  end

  def self.get_customer_by_ph phone_number
    customer = SbCustomer.where(:phone => phone_number)
    return customer
  end

end
