Deface::Override.new(
  name: 'admin_product_accepts_prescription',
  virtual_path: 'spree/admin/products/_form',
  insert_after: '[data-hook="admin_product_form_discontinue_on"]',
  text:
     '<div class="form-group data-hook="admin_product_form_accepts_prescription">
        <%= f.label :accepts_prescription do %>
          <%= f.check_box :accepts_prescription %> <%= Spree.t(:accepts_prescription) %>
        <% end %>
      </div>')


Deface::Override.new(
  name: 'admin_order_displays_prescriptions',
  virtual_path: 'spree/admin/orders/edit',
  insert_after: 'div#order-form-wrapper',
  text:'<%= render :partial => "admin_prescriptions", locals: { order: @order } %>')
