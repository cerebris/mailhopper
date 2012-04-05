module Mailhopper
  class Email < ActiveRecord::Base
    attr_accessible :to_address, :from_address, :cc_address, :bcc_address,
                    :reply_to_address, :subject, :content
    default_scope :order => 'created_at DESC'
    scope :unsent, :conditions => 'sent_at is null'

    validates :from_address, :presence => true

    def send!(delivery_method = nil)
      mail = Mail.new(self.content)
      mail[:bcc] = self.bcc_address unless self.bcc_address.blank?
      Base.mailer_class.wrap_delivery_behavior(mail, delivery_method || Base.default_delivery_method)
      mail.deliver
      self.sent_at = Time.now
      self.save!
    end
  end
end