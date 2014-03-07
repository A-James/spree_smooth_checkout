Spree::Order.class_eval do
    remove_checkout_step :delivery

    state_machine do
        before_transition :from => :address, :do => :create_proposed_shipments
        before_transition :from => :address, :do => :ensure_available_shipping_rates
        before_transition :from => :address, :do => :prefill_default_shipping_method
    end

    private

        def prefill_default_shipping_method
            logger.debug "Prefilling default shipping method."
            shipments.each do |s|
                logger.debug "Selected shipping rate for shipment[#{s.id}] for order[#{id}] is '#{s.selected_shipping_rate.try(:name) || 'nil'}'."
                if s.selected_shipping_rate_id == nil
                    sr = s.shipping_rates.first
                    logger.debug "Selected shipping rate #{sr.name} for order #{id}."
                    s.selected_shipping_rate_id = sr.id
                else
                    logger.debug "Order[#{id}] Skipping the prefilling of a shipping method as the shipping rate '#{s.selected_shipping_rate.name}' has already been chosen."
                end
            end
        end
end