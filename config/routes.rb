Spree::Core::Engine.routes.draw do
  # A customer should never see the delivery screen,
  # but just in case, redirect back to the checkout screen.
  get '/checkout/delivery', :to => redirect('/checkout')
end
