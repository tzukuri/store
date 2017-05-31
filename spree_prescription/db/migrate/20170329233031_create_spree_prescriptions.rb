class CreateSpreePrescriptions < ActiveRecord::Migration
  def change
    create_table :spree_prescriptions do |t|
      t.references :spree_order
      t.references :spree_line_item
      t.string :method
      t.attachment :attachment
    end
  end
end
