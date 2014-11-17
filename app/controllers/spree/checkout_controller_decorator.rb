Spree::CheckoutController.class_eval do
  alias_method :update_original, :update
  layout '/spree/layouts/spree_checkout'

  def update
    # is_summary comes from the form on the summary partial
    if is_summary_update
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

    if @order.update_from_params(params, permitted_checkout_attributes, request.headers.env)
      @order.temporary_address = !params[:save_user_address]

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

  def apply_coupon_code
    if params[:order] && params[:order][:coupon_code]
      @order.coupon_code = params[:order][:coupon_code]

      handler = PromotionHandler::Coupon.new(@order).apply
      if handler.error.present?
        flash.now[:error] = handler.error
        ## Spree_smooth_checkout specific
        # Added format.js:
        # apply_coupon_code breaks when called in an AJAX request
        # as it only contains format.html.

        respond_with(@order) do |format|
          format.html { render :edit }
          format.js {
            if is_summary_update
              render "summary"
            else
              render :edit
            end
          }
        end
        ## Spree_smooth_checkout specific - FIN
      elsif handler.success
        flash[:success] = handler.success
      end
    end
  end

  def is_summary_update
    params[:is_summary]
  end
end
