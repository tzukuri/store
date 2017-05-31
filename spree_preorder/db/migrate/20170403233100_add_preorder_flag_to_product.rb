class AddPreorderFlagToProduct < ActiveRecord::Migration
  def change
    add_column :spree_products, :preorder, :boolean, :default => false
  end
end
