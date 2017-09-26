module SmoothCheckoutHelper
  def step_class(order, step)
    order.state == step ? 'checkout-step-on' : 'checkout-step-off'
  end
end
