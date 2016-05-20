class SbTaxNDiscount < ActiveRecord::Base
  def self.create_a_tax tax_details
    status = SbTaxNDiscount.create(
        name: tax_details[:name],
        value_type: 1,
        percent: tax_details[:percent],
        created_at: Time.now,
        updated_at: Time.now
    )
    return status.id
  end

  def self.create_a_discount discount_details
    status = SbTaxNDiscount.create(
        name: discount_details[:name],
        value_type: 2,
        percent: discount_details[:percent],
        created_at: Time.now,
        updated_at: Time.now
    )
    return status.id
  end

  def self.get_tax_n_disc_by_id id_array
    taxndisc = SbTaxNDiscount.where(:id => id_array)
    return taxndisc
  end

end
