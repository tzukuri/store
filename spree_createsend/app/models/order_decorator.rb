Spree::Order.class_eval do

  def deliver_order_confirmation_email
    Spree::MailHandler.send_order_confirm_email self
    update_column(:confirmation_delivered, true)
  end

  def send_cancel_email
    Spree::MailHandler.send_order_cancel_email self
  end

end
