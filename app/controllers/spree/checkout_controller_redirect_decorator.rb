Spree::CheckoutController.class_eval do
  alias_method :redirect_to_original, :redirect_to

  # This method overrides the default redirect_to
  # to use a clientside redirect when the request
  # is made using XHR.
  def redirect_to(*args)
    result = redirect_to_original(*args)
    if request.xhr?
      return redirect_clientside_when_outside_checkout(result)
    else
      return result
    end
  end

  # Redirects within the checkout path are allowed
  # because they will be rendered correctly by the
  # checkout pages.
  # Redirects outside of the checkout path needs to
  # break out of the AJAX request to perform the
  # redirect.
  def redirect_clientside_when_outside_checkout(result)
    redirecting_outside_checkout = self.status == 302 && self.location.include?(checkout_path) == false
    if redirecting_outside_checkout
      mutate_http_redirect_to_clientside_redirect
      return true
    else
      return result
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
end
