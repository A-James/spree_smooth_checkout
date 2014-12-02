Spree::CheckoutController.class_eval do
  alias_method :permitted_checkout_attributes_original, :permitted_checkout_attributes

  def permitted_checkout_attributes
    permitted_checkout_attributes_original + permitted_personal_information_attributes
  end

  # Custom fields for specifying personal information.
  # Traditionally these fields are within the ship_address
  # and bill_address
  def permitted_personal_information_attributes
    [:firstname, :lastname, :phone]
  end
end
