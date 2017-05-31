Spree::Order.class_eval do

    # automatically create shipments and update amounts
    def select_default_shipping
      create_proposed_shipments
      shipments.find_each &:update_amounts
      update_totals
    end

end
