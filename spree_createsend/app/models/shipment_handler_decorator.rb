Spree::ShipmentHandler.class_eval do

  def send_shipped_email
    Spree::MailHandler.send_shipped_email @shipment
  end

end
