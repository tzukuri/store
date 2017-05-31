# add a checkbox to mark a product as preorder in spree admin
Deface::Override.new(
  name: 'admin_product_preorder',
  virtual_path: 'spree/admin/products/_form',
  insert_after: '[data-hook="admin_product_form_discontinue_on"]',
  text:
     '<div class="form-group data-hook="admin_product_form_preorder">
        <%= f.label :preorder do %>
          <%= f.check_box :preorder %> <%= Spree.t(:preorder) %>
        <% end %>
      </div>')
