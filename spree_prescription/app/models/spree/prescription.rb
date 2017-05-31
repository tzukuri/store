module Spree
  class Prescription < Spree::Base

    # belongs to both an order and a line item, but dependant on the line item only
    # if the order is destroyed, it all destroys associated line items which will
    # trigger a destroy on the prescription object associated with those line items
    belongs_to :spree_order, class_name: 'Spree::Order'
    belongs_to :spree_line_item, class_name: 'Spree::LineItem', :dependent => :destroy

    has_attached_file :attachment,
                       :path => ":rails_root/public/images/prescription/:id/:style_:basename.:extension",
                       :url => "/images/prescription/:id/:style_:basename.:extension"

    # doing our own custom validations
    do_not_validate_attachment_file_type :attachment

    validate :attachment_content_type_is_pdf_or_image
    validate :attachment_size
    validate :attachment_with_upload_method

    validates :method, inclusion: {
      in: ['email', 'upload', 'call', 'on_file'],
      message: "%{value} is not a valid prescription method"
    }

    # attempt to link this prescription with a line item
    def link_line_item(line_item)
      self.spree_line_item_id = line_item.id
      self.save!
    end

    def sku
      spree_line_item.product.sku unless spree_line_item.nil?
    end

    private

    # ensure that there is an attachment if the method is set to upload
    def attachment_with_upload_method
      if method == "upload" && !attachment?
        errors.add(:base, "Please make sure to upload your prescription.")
      end
    end

    def attachment_content_type_is_pdf_or_image
      if self.attachment? && !["application/pdf", "image/jpeg", "image/png", "image/jpg"].include?(self.attachment.content_type)
        errors.add(:base, "Please make sure your prescription is in .JPG, .PNG or .PDF format.")
      end
    end

    def attachment_size
      if self.attachment? && self.attachment.size > 5.megabytes
        errors.add(:base, "Please make sure your prescription is less than 5 megabytes.")
      end
    end
  end
end
