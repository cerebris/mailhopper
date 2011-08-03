require "mailhopper/engine"
require 'mailhopper/queue'
require 'mailhopper/base'

module Mailhopper
  class << self
    def setup(&block)
      Mailhopper::Base.setup(&block)
    end
  end
end

ActionMailer::Base.add_delivery_method :mailhopper, Mailhopper::Queue