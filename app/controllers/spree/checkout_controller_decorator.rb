Spree::CheckoutController.module_eval do
  alias_method :update_original, :update

  def update
    # is_summary comes from the form on the summary partial
    request_is_from_summary_section = params[:is_summary]
    if request_is_from_summary_section
      update_order_from_summary
    else
      update_original
    end
  end

  def update_order_from_summary
    # This method differs from the original update method
    # by not calling @order.next, which would transition
    # the order to the next step in the checkout.
    # The summary section should not transition the
    # order, it's only expected to update the order

    if @order.update_attributes(object_params)
      persist_user_address

      respond_to do |format|
        format.html { redirect_to checkout_state_path(@order.state) }
        format.js { render "summary" }
      end
    else
      respond_to do |format|
        format.html { render :edit }
        format.js { render "summary" }
      end
    end
  end
end
