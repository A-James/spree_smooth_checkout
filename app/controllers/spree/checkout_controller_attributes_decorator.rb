Spree::CheckoutController.class_eval do
  def permitted_checkout_attributes
    Spree::PermittedAttributes.checkout_attributes + [
        :bill_address_attributes => fixed_permitted_address_attributes,
        :ship_address_attributes => fixed_permitted_address_attributes,
        :payments_attributes => permitted_payment_attributes,
        :shipments_attributes => permitted_shipment_attributes
    ] + permitted_personal_information_attributes
  end

  # Custom fields for specifying personal information.
  # Traditionally these fields are within the ship_address
  # and bill_address
  def permitted_personal_information_attributes
    [:firstname, :lastname, :phone]
  end

  # id is added to fix a bug in Spree.
  # id required to update an address that has already been
  # entered. Without id, on an update, a new address is created.
  def fixed_permitted_address_attributes
    Spree::PermittedAttributes.address_attributes + [:id]
  end
end
