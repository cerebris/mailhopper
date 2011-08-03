require File.expand_path('../../../app/models/mailhopper/email', __FILE__)
require File.expand_path('../../../app/mailers/mailhopper/mailer', __FILE__)

module Mailhopper
  class Base
    cattr_accessor :email_class
    self.email_class = Mailhopper::Email

    cattr_accessor :mailer_class
    self.mailer_class = Mailhopper::Mailer

    cattr_accessor :default_delivery_method
    self.default_delivery_method = :smtp
    
    def self.setup
      yield self
    end
  end
end