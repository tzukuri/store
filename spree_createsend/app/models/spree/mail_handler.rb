module Spree
  class MailHandler

    @@auth = { :api_key => '0e6428051d2336c02a90f6e817a1802eb9e7f2a9a3f9a701' }

    # send an email when a customer's order has been shipped
    def self.send_shipped_email(shipment)
      order = shipment.order
      line_items = get_line_items(shipment)
      line_item_adjustments = get_line_item_adjustments(order)

      message = {
        to: "#{order.name} <#{order.email}>",
        AddRecipientsToList: true,
        data: {
          first_name: shipment.address.firstname,
          shipment_name: order.name,
          shipment_number: shipment.number,
          shipment_date: shipment.shipped_at,
          shipping_address_1: shipment.address.address1,
          shipping_address_2: shipment.address.address2,
          shipping_city: shipment.address.city,
          shipping_state: shipment.address.state_text,
          shipping_postcode: shipment.address.zipcode,
          shipping_country: shipment.address.country.name,
          shipping_phone: shipment.address.phone,
          line_items: line_items,
          line_item_adjustments: line_item_adjustments,
          carrier_number: shipment.tracking
        }
      }

      response = send('d5113e4d-435c-45eb-8f73-5c350b2152bd', message)
    end

    # send an email when a customer's order has been submitted
    def self.send_order_confirm_email(order)
      prescription_methods = order.prescriptions.map(&:method)
      prescription_method = ''

      # call is more important than email, so if both are on the order, only display the call content
      if prescription_methods.include? 'call'
        prescription_method = 'call'
      elsif prescription_methods.include? 'email'
        prescription_method = 'email'
      end

      line_items = get_line_items(order)
      line_item_adjustments = get_line_item_adjustments(order)

      message = {
        to: "#{order.name} <#{order.email}>",
        AddRecipientsToList: true,
        data: {
          first_name: order.billing_address.firstname,
          order_name: order.name,
          order_number: order.number,
          order_date: order.created_at,
          shipping_address_1: order.shipping_address.address1,
          shipping_address_2: order.shipping_address.address2,
          shipping_city: order.shipping_address.city,
          shipping_state: order.shipping_address.state_text,
          shipping_postcode: order.shipping_address.zipcode,
          shipping_country: order.shipping_address.country.name,
          shipping_phone: order.shipping_address.phone,
          billing_address_1: order.billing_address.address1,
          billing_address_2: order.billing_address.address2,
          billing_city: order.billing_address.city,
          billing_state: order.billing_address.state_text,
          billing_postcode: order.billing_address.zipcode,
          billing_country: order.billing_address.country.name,
          billing_phone: order.billing_address.phone,
          prescription_method: prescription_method,
          line_items: line_items,
          line_item_adjustments: line_item_adjustments,
          order_total: order.total
        }
      }

      response = send('362a47b0-b88d-41c8-83a5-f6b30d77ce6a', message)
    end

    # send an email when a customer's order has been cancelled
    def self.send_order_cancel_email(order)
      line_items = get_line_items(order)
      line_item_adjustments = get_line_item_adjustments(order)

      message = {
        to: "#{order.name} <#{order.email}>",
        AddRecipientsToList: true,
        data: {
          first_name: order.billing_address.firstname,
          order_name: order.name,
          order_number: order.number,
          order_date: order.created_at,
          line_items: line_items,
          line_item_adjustments: line_item_adjustments,
          order_total: order.total
        }
      }

      response = send('7a57c60e-0174-4bf8-99e3-0828b03559fe', message)
    end

    # send an email after a customer receives a refund
    def self.send_reimbursement_email(reimbursement)
      order = reimbursement.order

      message = {
        to: "#{order.name} <#{order.email}>",
        AddRecipientsToList: true,
        data: {
          first_name: order.billing_address.firstname,
          reimbursement_amount: reimbursement.total
        }
      }

      response = send('5ffdca1b-866c-40d3-8215-53b7537fbe50', message)
    end

    private

    def self.get_line_items(order)
      line_items = []

      order.line_items.each do |item|
        line_item = {
          name: item.name,
          quantity: item.quantity,
          variant: item.variant.options_text,
          preorder: item.product.preorder,
          amount: item.amount
        }
        line_items << line_item
      end

      return line_items
    end

    def self.get_line_item_adjustments(order)
      line_item_adjustments = []

      order.line_item_adjustments.each do |adjustment|
        a = {
          label: adjustment.label,
          amount: adjustment.amount.to_s
        }
        line_item_adjustments << a
      end

      return line_item_adjustments
    end

    def self.send(email_id, message)
      response = CreateSend::Transactional::SmartEmail.new(@@auth, email_id).send(message)
    end

  end
end
