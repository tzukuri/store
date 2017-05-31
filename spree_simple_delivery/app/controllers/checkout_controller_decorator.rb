Spree::CheckoutController.class_eval do

 #  called before the transition to the delivery state on the order state machine
 def before_delivery
    return if params[:order].present?

    packages = @order.shipments.map(&:to_package)
    @differentiator = Spree::Stock::Differentiator.new(@order, packages)

    @order.select_default_payment unless @order.payment_required?

    # automatically select default shipping for the user
    @order.select_default_shipping
    @order.next

    if @order.completed?
      session[:order_id] = nil
      flash.notice = Spree.t(:order_processed_successfully)
      flash[:commerce_tracking] = "nothing special"
      return redirect_to completion_route
    else
      return redirect_to checkout_state_path(@order.state)
    end

  end

end
