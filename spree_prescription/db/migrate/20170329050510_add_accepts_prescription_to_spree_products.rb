class AddAcceptsPrescriptionToSpreeProducts < ActiveRecord::Migration
  def change
    add_column :spree_products, :accepts_prescription, :boolean, :default => false
  end
end
