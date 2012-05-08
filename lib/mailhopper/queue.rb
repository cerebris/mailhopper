module Mailhopper
  class Queue
    def initialize(options)
    end

    def deliver!(mail)
      Base.email_class.create_from_mail(mail)
    end
  end
end
