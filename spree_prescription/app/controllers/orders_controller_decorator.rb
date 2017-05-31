Spree::OrdersController.class_eval do

  # overriding variant populate from dynamic variants extension
  def variant_populate
    order = current_order(create_order_if_necessary: true)
    product = Spree::Product.find(params[:product_id])
    option_values_ids = params[:options].present? ? params[:options].values : []
    option_values = Spree::OptionValue.where(id: option_values_ids)
    variant = product.try_variant option_values
    quantity = params[:quantity].to_i

    # 2,147,483,647 is crazy. See issue #2695.
    if quantity.between?(1, 2_147_483_647)
      begin
        # attempt to add a prescription to the order
        prescription = add_prescription(order, product, params[:prescription_method], params[:prescription])
        # add the variant as a line item in the order
        order.contents.add(variant, quantity)
        # associate the prescription with a line item if a prescription object has been created
        prescription.link_line_item(order.line_items.where(variant_id: variant.id).take) unless prescription.nil?
      rescue ActiveRecord::RecordInvalid => e
        error = e.record.errors.full_messages.join(", ")
      end
    else
      error = Spree.t(:please_enter_reasonable_quantity)
    end

    if error
      flash[:error] = error
      redirect_back_or_default(spree.root_path)
    else
      respond_with(order) do |format|
        format.html { redirect_to cart_path }
      end
    end
  end

  private

  def add_prescription(order, product, method, attachment)
    puts "\n\n\n\n"
    puts attachment

    return unless !method.nil?

    @prescription = Spree::Prescription.new(spree_order_id: order.id, method: method)

    if !attachment.nil?
      @prescription.attachment = attachment[:attachment]
    end

    # attempt to save the prescription object, if the prescription is invalid
    # a RecordInvalid error will be raised
    @prescription.save!

    return @prescription
  end
end
