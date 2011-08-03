module Mailhopper
  class Queue
    def initialize(options)
    end

    def deliver!(mail)
      Base.email_class.create({
        :to_address => mail.to.to_s,
        :from_address => mail.from.to_s,
        :cc_address => mail.cc.to_s,
        :bcc_address => mail.bcc.to_s,
        :reply_to_address => mail.reply_to.to_s,
        :subject => mail.subject,
        :content => mail.to_s
      })
    end
  end
end
