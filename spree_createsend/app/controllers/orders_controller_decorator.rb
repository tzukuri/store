Spree::Admin::OrdersController.class_eval do
  def resend
    Spree::MailHandler.send_order_confirm_email @order
    flash[:success] = Spree.t(:order_email_resent)
    redirect_to spree.edit_admin_order_url(@order)
  end
end
