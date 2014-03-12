Spree::Order.class_eval do
    state_machine do
      after_transition :to => :delivery, :do => :skip_delivery
    end

    private
      def skip_delivery
        # Progress the state machine to the next state,
        # skipping the current 'delivery' state.
        self.next
      end
end
