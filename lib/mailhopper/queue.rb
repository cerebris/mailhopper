module Mailhopper
  class Queue
    def initialize(options)
    end

    def deliver!(mail)
      Base.email_class.create({
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
