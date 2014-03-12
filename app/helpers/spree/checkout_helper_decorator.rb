Spree::CheckoutHelper.module_eval do
  def checkout_states
    # Remove the delivery stage from the breadcrumb to stop the user transitioning
    # to the delivery stage in the checkout process.
    # Delivery can't be removed from the checkout state_machine without
    # also removing the ability to deliver at all so we remove it from the
    # UI instead.
    @order.checkout_steps - ["delivery"]
  end
end
