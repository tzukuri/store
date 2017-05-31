Deface::Override.new(
  name: 'add_preorder_indicator_to_product_show',
  virtual_path: 'spree/products/show',
  insert_after: 'p#price',
  text: '<% if @product.preorder? %>
           <%= render :partial => "product_show_preorder_indicator" %>
         <% end %>')

Deface::Override.new(
  name: 'add_preorder_indicator_to_products',
  virtual_path: 'spree/shared/_products',
  insert_after: 'span.price.selling.lead',
  text: '<% if product.preorder? %>
          <%= render :partial => "products_preorder_indicator" %>
        <% end %>')
