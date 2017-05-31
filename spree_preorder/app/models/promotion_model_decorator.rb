# Spree::Promotion.class_eval do
#   def line_item_actionable?(order, line_item)
#
#     puts "\n\n\n\n CHECKING ACTIONABLE LINE ITEM \n\n\n\n"
#
#     # otherwise, only touch non-preorder line items
#     false if line_item.product.preorder
#
#     # process whichever line items are remaining as normal
#     if eligible? order
#       rules = eligible_rules(order)
#       if rules.blank?
#         true
#       else
#         rules.send(match_all? ? :all? : :any?) do |rule|
#           rule.actionable? line_item
#         end
#       end
#     else
#       false
#     end
#   end
# end
