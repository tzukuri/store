# Spree::Promotion::Actions::CreateItemAdjustments.class_eval do
#   def perform(options = {})
#     order, promotion = options[:order], options[:promotion]
#     create_unique_adjustments(order, order.line_items) do |line_item|
#       promotion.line_item_actionable?(order, line_item)
#     end
#   end
# end
