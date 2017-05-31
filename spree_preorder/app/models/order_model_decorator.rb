# Spree::Order.class_eval do
#   state_machine do
#     after_transition :to => :complete, :do => :add_preorder_adjustments
#   end
#
#   # after the order has transitioned to the completed state (payment has been accepted)
#   # check if there are any preorder products in the line items and manually create adjustments
#   # and reload the order so that it has the correct state
#   def add_preorder_adjustments
#
#     preorder_line_items.each do |line_item|
#       line_item.quantity.times do |i|
#         adjustments.build(order: self).update_attributes(amount: 285, label: "#{product.name} - Preorder Remainder Amount")
#       end
#     end
#
#     promotions.each do |promotion|
#       promotion.actions.each do |action|
#         next if action.type != "Spree::Promotion::Actions::CreateItemAdjustments"
#         puts "\n\n\n\n CREATING ADJUSTMENTS FROM PROMOTION ACTIONS \n\n\n\n"
#         create_unique_adjustments(order, preorder_line_items)
#       end
#     end
#
#     # order = payload[:order]
#     # return unless self.class.order_activatable?(order)
#     #
#     # payload[:promotion] = self
#     #
#     # # Track results from actions to see if any action has been taken.
#     # # Actions should return nil/false if no action has been taken.
#     # # If an action returns true, then an action has been taken.
#     # results = actions.map do |action|
#     #   action.perform(payload)
#     # end
#     # # If an action has been taken, report back to whatever activated this promotion.
#     # action_taken = results.include?(true)
#     #
#     # if action_taken
#     # # connect to the order
#     # # create the join_table entry.
#     #   self.orders << order
#     #   self.save
#     # end
#     #
#     # action_taken
#
#     # create adjustments for preorders only
#     # create_unique_adjustments(order, preorder_line_items)
#
#     # promotions.each do |promotion|
#     #   promotion.actions
#     # end
#
#
#     # line_items.each do |line_item|
#     #   product = line_item.product
#     #   # if this is a preorder product add an adjustment for each quantity
#     #   if product.preorder?
#     #     line_item.quantity.times do |i|
#     #       # todo: pull the amount from product.preorder_remainder
#     #       adjustments.build(order: self).update_attributes(amount: 285, label: "#{product.name} - Preorder Remainder Amount")
#     #       adjustments.build(order: self).update_attributes(amount: 0, label: "")
#     #     end
#     #
#     #     # create_unique_adjustments(order, order.line_items) do |line_item|
#     #     #   promotion.line_item_actionable?(order, line_item)
#     #     # end
#     #
#     #     # perform any adjustments where the action creates line item adjustments
#     #     # all other promotion action types don't apply here as they are applied at
#     #     # the order level
#     #     # promotions.each do |promotion|
#     #     #   promotion.actions.where(type: "Spree::Promotion::Actions::CreateItemAdjustments").each do |action|
#     #     #     action.perform(self)
#     #     #   end
#     #     # end
#     #
#     #   end
#     # end
#
#     reload.update_with_updater!
#   end
#
#   # return all line items that have a preorder product
#   def preorder_line_items
#     line_items.joins(:product).where("preorder = true")
#   end
#
#   def create_item_adjustment_actions
#     promotions.join(:promotion_actions).where("action.promotion_id = 2")
#     # promotions.joins(:promotion_actions).where(type: "Spree::Promotion::Actions::CreateItemAdjustments")
#   end
# end
