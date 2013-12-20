module Mailhopper
  class Email < ActiveRecord::Base
    # Starting from Rails 4 <tt>attr_accessible</tt> is deprecated in favour of Strong parameters
    if Rails::VERSION::MAJOR < 4
      attr_accessible :to_address, :from_address, :cc_address, :bcc_address,
                      :reply_to_address, :subject, :content
    end

    default_scope lambda { order('created_at DESC') }
    scope :unsent, lambda { where(:sent_at => nil) }

    validates :from_address, :presence => true

    def send!(delivery_method = nil)
      mail = Mail.new(self.content)
      mail[:bcc] = self.bcc_address unless self.bcc_address.blank?
      Base.mailer_class.wrap_delivery_behavior(mail, delivery_method || Base.default_delivery_method)
      mail.deliver
      self.sent_at = Time.now
      self.save!
    end

    class << self
      def create_from_mail(mail)
        create({
          :to_address       => address_to_s(mail.to),
          :from_address     => address_to_s(mail.from),
          :cc_address       => address_to_s(mail.cc),
          :bcc_address      => address_to_s(mail.bcc),
          :reply_to_address => address_to_s(mail.reply_to),
          :subject          => mail.subject,
          :content          => mail.to_s
        })
      end

    private

      def address_to_s(field)
        if field
          if field.is_a?(Array)
            field.join(',') unless field.empty?
          else
            field
          end
        end
      end
    end
  end
end