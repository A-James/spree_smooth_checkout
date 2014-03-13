Spree::CheckoutController.module_eval do
  alias_method :update_original, :update

  def update
    if params[:dont_transition]
      if @order.update_attributes(object_params)
        persist_user_address
        redirect_to checkout_state_path(@order.state)
      else
        render :edit
      end
    else
      update_original
    end
  end
end
