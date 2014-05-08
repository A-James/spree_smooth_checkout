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

    def firstname
      address = bill_address || ship_address
      address.try(:firstname)
    end

    def firstname=(firstname)
      if bill_address
        bill_address.firstname = firstname
      end

      if ship_address
        ship_address.firstname = firstname
      end
    end

    def lastname
      address = bill_address || ship_address
      address.try(:lastname)
    end

    def lastname=(lastname)
      if bill_address
        bill_address.lastname = lastname
      end

      if ship_address
        ship_address.lastname = lastname
      end
    end

    def phone
      address = bill_address || ship_address
      address.try(:phone)
    end

    def phone=(phone)
      if bill_address
        bill_address.phone = phone
      end

      if ship_address
        ship_address.phone = phone
      end
    end

    def require_phone?
      bill_address.try(:require_phone?) || ship_address.try(:require_phone?)
    end

    private
      def skip_delivery
        # Progress the state machine to the next state,
        # skipping the current 'delivery' state.
        self.next
      end
end
