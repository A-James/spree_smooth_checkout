Spree::CheckoutController.module_eval do
  alias_method :update_original, :update
  alias_method :redirect_to_original, :redirect_to
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

  def apply_coupon_code
    if params[:order] && params[:order][:coupon_code]
      @order.coupon_code = params[:order][:coupon_code]

      coupon_result = Spree::Promo::CouponApplicator.new(@order).apply
      if coupon_result[:coupon_applied?]
        flash[:success] = coupon_result[:success] if coupon_result[:success].present?
      else
        flash.now[:error] = coupon_result[:error]
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
      end
    end
  end

  # This method overrides the default redirect_to
  # to use a clientside redirect when the request
  # is made using XHR.
  def redirect_to(*args)
    redirect_to_original(*args)
    return unless request.xhr?

    redirect_clientside_when_outside_checkout
  end

  # Redirects within the checkout path are allowed
  # because they will be rendered correctly by the
  # checkout pages.
  # Redirects outside of the checkout path needs to
  # break out of the AJAX request to perform the
  # redirect.
  def redirect_clientside_when_outside_checkout
    redirecting_outside_checkout = self.status == 302 && self.location.include?(checkout_path) == false
    if redirecting_outside_checkout
      mutate_http_redirect_to_clientside_redirect
    end
  end

  def mutate_http_redirect_to_clientside_redirect
    # record the redirect location before resetting
    @location = self.location

    reset_http_redirect

    # The redirect template performs a client-side redirect to stop
    # the browser following the redirects automatically as part of
    # the AJAX request.
    render "redirect"
  end

  def reset_http_redirect
    self.status = 200
    headers.delete("Location")
    self.response_body = nil
  end

  def is_summary_update
    params[:is_summary]
  end
end
