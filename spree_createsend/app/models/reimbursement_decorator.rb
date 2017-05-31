Spree::Reimbursement.class_eval do
  def send_reimbursement_email
    Spree::MailHandler.send_reimbursement_email self
  end
end
