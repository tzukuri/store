Spree::Order.class_eval do

  attr_accessor :prescription_file

  has_many :prescriptions, :foreign_key => 'spree_order_id', :class_name => 'Spree::Prescription'
  
end
