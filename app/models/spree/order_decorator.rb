Spree::Order.class_eval do
    state_machine do
      after_transition :to => :delivery, :do => :skip_delivery
    end

    # Force the confirmation screen to never appear.
    # The checkout pages have been modified so that
    # the customer always knows what they're buying.
    def confirmation_required?
      false
    end

    private
      def skip_delivery
        # Progress the state machine to the next state,
        # skipping the current 'delivery' state.
        self.next
      end
end
